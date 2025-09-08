import 'dart:io';

import 'package:chat_app/widgets/user_image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final _firebase = FirebaseAuth.instance;

enum Operation { login, signup }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();
  Operation operation = Operation.login;
  String? _enteredEmail;
  String? _enteredPassword;
  File? _pickedImage;
  bool _isLoading = false;

  void _submit() async {
    if (!_form.currentState!.validate() ||
        operation == Operation.signup && _pickedImage == null) {
      return;
    }
    _form.currentState!.save();

    try {
      setState(() {
        _isLoading = true;
      });

      if (operation == Operation.login) {
        final userCredentials = await _firebase.signInWithEmailAndPassword(
          email: _enteredEmail!,
          password: _enteredPassword!,
        );
      } else {
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
          email: _enteredEmail!,
          password: _enteredPassword!,
        );

        final storageRef = FirebaseStorage.instance
            .ref()
            .child('users_images')
            .child('${userCredentials.user!.uid}.jpg');

        await storageRef.putFile(_pickedImage!);

        final imageUrl = await storageRef.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredentials.user!.uid)
            .set({
              'username': 'username',
              'email': _enteredEmail,
              'image_url': imageUrl,
            });
      }
    } on FirebaseAuthException catch (error) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(content: Text(error.message ?? 'Authentication faild')),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                width: 200,
                child: Image.asset('assets/images/chat.png'),
              ),
              Card(
                margin: EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _form,
                      child: Column(
                        children: [
                          if (operation == Operation.signup)
                            UserImagePicker(
                              onPickImage: (pickedImage) =>
                                  _pickedImage = pickedImage,
                            ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email Address',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                            onSaved: (newValue) => _enteredEmail = newValue!,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Password',
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return 'Password must be at least 6 characters long.';
                              }
                              return null;
                            },
                            onSaved: (newValue) => _enteredPassword = newValue!,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          if (_isLoading) CircularProgressIndicator(),
                          if (!_isLoading)
                            ElevatedButton(
                              onPressed: _submit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.primaryContainer,
                              ),
                              child: Text(
                                operation == Operation.login
                                    ? 'Login'
                                    : 'Sign up',
                              ),
                            ),
                          if (!_isLoading)
                            TextButton(
                              onPressed: () => setState(() {
                                operation = operation == Operation.login
                                    ? Operation.signup
                                    : Operation.login;
                              }),
                              child: Text(
                                operation == Operation.login
                                    ? 'Create an account'
                                    : 'Already have an accout?',
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
