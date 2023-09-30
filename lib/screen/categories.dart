import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screen/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen(
      {super.key,
      //// required this.onToggleFavourite,
      required this.availableMeals});

  ////final void Function(Meal meal) onToggleFavourite;
  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      // lowerBound: 0,
      // upperBound: 1,-->default values
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    // final filteredMeals = dummyMeals.where((meal) => meal.categories.contains(category.id),).toList();
    // void _selectCategory() {
    // Stack of Screens --> Last In First Out
    // context is not globally available as we are creating a method in StatelessWidget class...hence we need to accept a context value
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      /*route*/ MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          ////onToggleFavourite: onToggleFavourite,
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
    // alternavtive code:
    //Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        //   appBar: AppBar(
        //     title: const Text('Pick you Category'),
        //   ),
        GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // setting number of columns in my GirdView
        childAspectRatio: 1.5,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        // for-in loop is alternative for map function
        // availableCategories.map((category) => CategoryGridItem(category: category)).toList(),
        for (final caTegory in availableCategories)
          // do not use parentheses here when using for-in loop
          CategoryGridItem(
            category: caTegory,
            onSelectCategory: () => _selectCategory(context, caTegory),
          ),
      ],
      // ),-->Scaffold
    );
  }
}
