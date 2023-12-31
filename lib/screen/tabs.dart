import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:meals_app/data/dummy_data.dart';
// import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/favorities_provider.dart';
import 'package:meals_app/providers/filters_provider.dart';
// import 'package:meals_app/providers/meals_provider.dart';
import 'package:meals_app/screen/categories.dart';
import 'package:meals_app/screen/filters.dart';
import 'package:meals_app/screen/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

// class TabsScreen extends StatefulWidget {
class TabsScreen extends ConsumerStatefulWidget {
  // changing to ConsumerStatefulWidget from StatefulWidget..riverpod package
// Stateful --> ConsumerStatefulWidget, Stateless --> ConsumerWidget
  const TabsScreen({super.key});

  @override
  // State<TabsScreen> createState() {
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

// class _TabsScreenState extends State<TabsScreen> {
class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  //// final List<Meal> _favouriteMeal = [];--> not been used....riverpod
  // Map<Filter, bool> _selectedFilters = {
  //   Filter.glutenFree: false,
  //   Filter.lactoseFree: false,
  //   Filter.vegan: false,
  //   Filter.vegetarian: false,
  // }; // these are initial values for filters...these should be updated ehen we receive updated values from filters screen
  // Map<Filter, bool> _selectedFilters = kInitialFilters;

  // void showInfoMessage(String message) {
  //   ScaffoldMessenger.of(context).clearSnackBars();
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(message),
  //       duration: const Duration(seconds: 1),
  //     ),
  //   );
  // } ==> shifted to meal_details.dart

  /*void _toggleMealFavouriteStatus(Meal meal) {
    final isExisting = _favouriteMeal.contains(meal);

    if (isExisting) {
      setState(() {
        _favouriteMeal.remove(meal);
      });
      showInfoMessage("Meal is no longer a favourite");
    } else {
      setState(() {
        _favouriteMeal.add(meal);
      });
      showInfoMessage("Marked as favourite!");
    }
  } ==> managed in StateNotifier class*/

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  // void _setScreen(String identifier) {
  //   if (identifier == "filters") {
  //     Navigator.pop(context);
  //     // closing the Drawer before getting Navigate away
  //     Navigator.of(context).push(
  //       MaterialPageRoute(
  //         builder: (ctx) {
  //           return const FiltersScreen();
  //         },
  //       ),
  //     );
  //   } else {
  //     Navigator.pop(context);
  //     // else refers to MealsScreen hence on tapping meals instead of filters we will close the drawer
  //   }
  // }

  // more optimized code below

  // void _setScreen(String identifier) {
  //   Navigator.pop(context);
  //   if (identifier == "filters") {
  //     Navigator.of(context).push(
  //       MaterialPageRoute(
  //         builder: (ctx) {
  //           return const FiltersScreen();
  //         },
  //       ),
  //     );
  //   }
  // }
  void _setScreen(String identifier) async {
    Navigator.pop(context);
    if (identifier == "filters") {
      // final result =
      await Navigator.of(context).push< /*return type of push*/
          Map /*itself a genric type*/ < /*keys will be of type Filter*/ Filter,
              /*value type of a key*/ bool>>(
        MaterialPageRoute(
          builder: (ctx) {
            return const FiltersScreen(
                // currentFilter: _selectedFilters,
                );
          },
        ),
      );
      // setState(() {
      //   _selectedFilters =
      //       result ?? /*allows you to setup the conditional fallback value*/
      //           kInitialFilters; // ?? checks wheather the value infront is null and if nul then it will use the fallback value afer ??
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final availableMeals = dummyMeals.where((meal) {
    // widget--> reaching out widget of State class and ref-->allows to setup listeners to providers
    // ref.read(provider);// read()--> allows to read the value of a provider
    // final meals = ref.watch(
    //     mealsProvider); // watch()--> allows to listen to a provider...setting up a listener that makes sure that build method is called whenever the value(data) of the provider changes
    // final selectedActiveFilters = ref.watch(filtersProvider);
    final availableMeals = ref.watch(filteredMealProvider);
    // final availableMeals = meals.where((meal) {
    //   // using mealsProvider from riverpod package
    //   // true-->if meal should be kept
    //   //false--> if meal should be dropped
    //   if (selectedActiveFilters[
    //           Filter.glutenFree]! /*'!' because it is never a null value*/ &&
    //       !meal.isGlutenFree /*meal should not be Gluten free*/) {
    //     return false;
    //   }
    //   if (selectedActiveFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
    //     return false;
    //   }
    //   if (selectedActiveFilters[Filter.vegetarian]! && !meal.isVegetarian) {
    //     return false;
    //   }
    //   if (selectedActiveFilters[Filter.vegan]! && !meal.isVegan) {
    //     return false;
    //   }
    //   return true;
    // }).toList(); // so that I actually return a List and not a iterable...hence now we should pass this list to Catgories Screen

    Widget activePage = CategoriesScreen(
      //// onToggleFavourite: _toggleMealFavouriteStatus,
      availableMeals: availableMeals,
    );
    var activePageTitle = "Categories";

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoritesMealProvider);
      // activePage = const MealsScreen(title: "Favourite Meals", meals: []);
      activePage = MealsScreen(
        // meals: [],
        // meals: _favouriteMeal,
        meals: favoriteMeals,
        ////onToggleFavourite: _toggleMealFavouriteStatus,
      );
      activePageTitle = "Your Fav";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favourites",
          ),
        ],
      ),
    );
  }
}
