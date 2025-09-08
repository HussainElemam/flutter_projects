import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:shopping_list_app/data/categories.dart';
import 'package:shopping_list_app/models/category.dart';
import 'package:shopping_list_app/models/grocery_item.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() {
    return _AddItemState();
  }
}

class _AddItemState extends State<AddItem> {
  final _formKey = GlobalKey<FormState>();
  var _selectedName = '';
  var _selectedQuantity = 1;
  var _selectedCategory = categories[Categories.fruit]!;
  var _isSending = false;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _isSending = true;

      final url = Uri.https(
        'flutter-prep-b5b25-default-rtdb.firebaseio.com',
        'shopping-list.json',
      );

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': _selectedName,
          'quantity': _selectedQuantity,
          'category': _selectedCategory.title,
        }),
      );

      final Map<String, dynamic> resData = json.decode(response.body);

      // print(response.statusCode);
      // print(response.body);

      Navigator.of(context).pop(
        GroceryItem(
          id: resData['name'],
          name: _selectedName,
          quantity: _selectedQuantity,
          category: _selectedCategory,
        ),
      );
    }
  }

  void _resetForm() {
    _formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                autofocus: true,
                maxLength: 50,
                decoration: InputDecoration(
                  label: Text('Name'),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "you must enter a name that has 1 to 50 characters";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _selectedName = newValue!;
                },
              ),
              Row(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        label: Text('Quantity'),
                      ),
                      initialValue: _selectedQuantity.toString(),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! <= 0) {
                          return "you must enter a positive value";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _selectedQuantity = int.parse(newValue!);
                      },
                    ),
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                      initialValue: _selectedCategory,
                      items: [
                        for (final category in categories.entries)
                          DropdownMenuItem(
                            value: category.value,
                            child: Row(
                              spacing: 8,
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  color: category.value.color,
                                ),
                                Text(category.value.title),
                              ],
                            ),
                          ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _isSending ? null : _resetForm,
                    child: Text('Reset'),
                  ),
                  ElevatedButton(
                    onPressed: _isSending ? null : _submitForm,
                    child: _isSending
                        ? SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(),
                          )
                        : Text('Add Item'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
