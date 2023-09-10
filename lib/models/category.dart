import 'package:flutter/material.dart';

class Category {
  const Category(
      {required this.id,
      required this.title,
      this.color = Colors.orange /*setting default colour as Orange*/});
      
  final String id;
  final String title;
  final Color color;
}
