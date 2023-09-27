import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier</*to tell flutter what kind of data will be managed by this notifier/class*/List<Meal>>{
  FavoriteMealsNotifier() : super([]/*iniial type data that will be stored in this notifier*/);
  void _toggleMealFavouriteStatus(Meal meal){
    
  }
}
final favoritesMealProvider = StateNotifierProvider();// this StateNotifierProvider class works with another class StateNotifier class