import 'package:flutter/material.dart';
import 'package:udemy_app/data/dummy_data.dart';
import 'package:udemy_app/widget/category_grid_item.dart';

class CategoriresScreen extends StatelessWidget {
  const CategoriresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Your Category !'),
      ),
      body: GridView(
        padding: const EdgeInsets.all(15),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories) CategoryGridItem(category: category),
        ],
      ),
    );
  }
}
