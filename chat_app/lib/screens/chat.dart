import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chat'),
        actions: [
          IconButton(
            onPressed: () => FirebaseAuth.instance.signOut(),
            icon: Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: Center(child: Text('logged in')),
    );
  }
}
