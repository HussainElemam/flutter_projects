import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shopping_list_app/data/categories.dart';

import 'package:shopping_list_app/models/grocery_item.dart';
import 'package:shopping_list_app/widgets/add_item.dart';

class GroceriesList extends StatefulWidget {
  const GroceriesList({super.key});

  @override
  State<GroceriesList> createState() => _GroceriesListState();
}

class _GroceriesListState extends State<GroceriesList> {
  List<GroceryItem> _groceriesList = [];
  var _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https(
      'flutter-prep-b5b25-default-rtdb.firebaseio.com',
      'shopping-list.json',
    );

    final http.Response response = await http.get(url);

    if (response.statusCode >= 400) {
      setState(() {
        _errorMessage = 'Faild to load data. Please try again later.';
        _isLoading = false;
      });
      return;
    }

    if (response.body == 'null') {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final Map<String, dynamic> data = json.decode(response.body);

    final List<GroceryItem> loadedItems = [];

    // print(json.decode(data.body));
    // print(data.body);

    for (final item in data.entries) {
      final category = categories.values.firstWhere(
        (currCategory) => currCategory.title == item.value['category'],
      );
      loadedItems.add(
        GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category,
        ),
      );
    }

    setState(() {
      _groceriesList = loadedItems;
      _isLoading = false;
    });
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(builder: (ctx) => AddItem()),
    );

    if (newItem != null) {
      setState(() {
        _groceriesList.add(newItem);
      });
    }
  }

  void _deleteItem(index) async {
    GroceryItem? removed;

    setState(() {
      removed = _groceriesList.removeAt(index);
    });

    final url = Uri.https(
      'flutter-prep-b5b25-default-rtdb.firebaseio.com',
      'shopping-list/${removed!.id}.json',
    );

    final response = await http.delete(url);

    print(response);

    if (response.statusCode >= 400) {
      setState(() {
        _groceriesList.insert(index, removed!);
      });

      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error accured. The item was not removed'),
          ),
        );
      }
    }

    // ScaffoldMessenger.of(context).clearSnackBars();
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text('Item removed'),
    //     action: SnackBarAction(
    //       label: 'Undo',
    //       onPressed: () {
    //         setState(() {
    //           _groceriesList.insert(index, removed!);
    //         });
    //       },
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    print(_isLoading);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : (_errorMessage != null)
          ? Center(child: Text(_errorMessage!))
          : _groceriesList.isEmpty
          ? Center(child: Text('You have no grocery items yet'))
          : ListView.builder(
              itemCount: _groceriesList.length,
              itemBuilder: (context, index) => Dismissible(
                background: Container(
                  color: Theme.of(context).colorScheme.error,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 24),
                  child: Icon(Icons.delete),
                ),
                secondaryBackground: Container(
                  color: Theme.of(context).colorScheme.error,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 24),
                  child: Icon(Icons.delete),
                ),

                key: ValueKey(_groceriesList[index].id),
                onDismissed: (direction) {
                  _deleteItem(index);
                },
                child: ListTile(
                  leading: Container(
                    height: 24,
                    width: 24,
                    color: _groceriesList[index].category.color,
                  ),
                  title: Text(_groceriesList[index].name),
                  trailing: Text(_groceriesList[index].quantity.toString()),
                ),
              ),
            ),
    );
  }
}
