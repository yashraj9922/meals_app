import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick you Category'),
      ),
      body: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // setting number of columns in my GirdView
          childAspectRatio: 1.3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          // for-in loop is alternative for map function
          // availableCategories.map((category) => CategoryGridItem(category: category)).toList(),
          for (final category in availableCategories)
            // do not use parentheses here when using for-in loop
            CategoryGridItem(category: category),
        ],
      ),
    );
  }
}
