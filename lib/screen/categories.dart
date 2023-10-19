import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screen/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  // to add explicit animation....class should be in Stateful Widget
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
  late AnimationController
      _animationController; // late is used to tell dart that _animationController initially hasno value but later it will be assigned...
  //there is slightly a timing difference between initState() and build() method...so we need to use late keyword to tell dart that it will be assigned later
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync:
          this, // vsync is used to make sure that this animation runs for each fram i.e., 60fps
      duration: const Duration(seconds: 2),
      lowerBound: 0,
      upperBound: 1,
      // lowerBound: 0,
      // upperBound: 1,-->default values
    );
    //starting an animation
    _animationController.forward();
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
        // ),-->Scaffold

        AnimatedBuilder(
      animation: _animationController,
      child: GridView(
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
      ),
      // builder: (context, child) => Padding(
      //       padding: EdgeInsets.only(
      //           top: 100 - _animationController.value * 100),// slides up animation
      //       // EdgeInsets.only(top: _animationController.value * 100), --> slide down animation

      builder: (context, child) => SlideTransition(
        // position: _animationController.drive(
        //   Tween(
        //     begin: const Offset(0, 0.3),
        //     end: const Offset(0, 0),
        //   )
        // ),
        position: Tween(
          begin: const Offset(0, 0.3),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        ),
        child: child,
      ),
    );
    // returning Padding Widget and not directly Girdview will make sure that Gridview widget is not build 60 times but only the padding widget
  }
}
