// ignore_for_file: avoid_print, use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:udemy_app/data/categories.dart';
import 'package:udemy_app/models/grocery_item.dart';
import 'package:udemy_app/widgets/new_item.dart';

class GrocaryList extends StatefulWidget {
  const GrocaryList({super.key});

  @override
  State<GrocaryList> createState() => _GrocaryListState();
}

class _GrocaryListState extends State<GrocaryList> {
  List<GroceryItem> _groceryItems = [];
  var isLoading = true;
  String? error;
  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https('flutter-prep-23395-default-rtdb.firebaseio.com', 'shopping-list.json');

    try {
      final response = await http.get(url);
      print(response.body);
      print(response.statusCode);

      if (response.statusCode >= 400) {
        setState(() {
          error = 'Not able to fetch the data. Please try again later.';
        });
        return;
      }

      if (response.body == 'null') {
        setState(() {
          isLoading = false;
        });
        return;
      }

      final Map<String, dynamic> listData = json.decode(response.body);
      final List<GroceryItem> loadedItems = [];
      for (final item in listData.entries) {
        final category = categories.entries.firstWhere((element) => element.value.title == item.value['category']).value;
        loadedItems.add(GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category,
        ));

        setState(() {
          _groceryItems = loadedItems;
          isLoading = false;
        });
      }
    } catch (err) {
      setState(() {
        error = 'Something Went Wrong. Please try again later.';
      });
    }
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );
    if (newItem == null) {
      return;
    }
    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _removeItems(GroceryItem item) async {
    final index = _groceryItems.indexOf(item);
    setState(() {
      _groceryItems.remove(item);
    });
    late String snackMsg = "is removed";
    Color color = const Color.fromARGB(255, 255, 0, 0);
    final url = Uri.https('flutter-prep-23395-default-rtdb.firebaseio.com', 'shopping-list/${item.id}.json');
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _groceryItems.insert(index, item);
      snackMsg = 'is not able to remove from Database. Please try again later';
      color = const Color.fromARGB(255, 1, 226, 31);
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${item.name} $snackMsg',
          selectionColor: color,
        ),
        duration: const Duration(milliseconds: 1000),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text(
        "No Item Added Yet!",
        style: TextStyle(
          fontSize: 30,
        ),
      ),
    );

    if (isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (ctx, index) => Dismissible(
          key: ValueKey(_groceryItems[index].id),
          onDismissed: (direction) {
            _removeItems(_groceryItems[index]);
          },
          child: ListTile(
            title: Text(_groceryItems[index].name),
            leading: Container(
              width: 24,
              height: 24,
              color: _groceryItems[index].category.color,
            ),
            trailing: Text(_groceryItems[index].quantity.toString()),
          ),
        ),
      );
    }

    if (error != null) {
      content = Center(
        child: Text(error!),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
