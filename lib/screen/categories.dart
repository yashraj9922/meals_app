import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick you Category'),
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // setting number of columns in my GirdView
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        children: const [
          Text(
            "1",
            style: TextStyle(color: Colors.cyanAccent),
          ),
          Text(
            "1",
            style: TextStyle(color: Colors.cyanAccent),
          ),
          Text(
            "1",
            style: TextStyle(color: Colors.cyanAccent),
          ),
          Text(
            "1",
            style: TextStyle(color: Colors.cyanAccent),
          ),
          Text(
            "1",
            style: TextStyle(color: Colors.cyanAccent),
          ),
        ],
      ),
    );
  }
}
