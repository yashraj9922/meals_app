import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

class FavoriteMealsNotifier
    extends StateNotifier< /*to tell flutter what kind of data will be managed by this notifier/class*/
        List<Meal>> {
  FavoriteMealsNotifier()
      : super([] /*iniial type data that will be stored in this notifier*/);

  //when using StateNotifier u are not allowed to edit the existing stored values in memory instead u should always create a new one(.add, .remove is not allowed)
  bool toggleMealFavoriteStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal);
    if (mealIsFavorite) {
      state = state
          .where((m) => /*shuold return false*/ m.id != meal.id)
          .toList(); // .where will always return a new list
          return false;
    } else {
      // set a state such that it should have all the existing items and also new ones added
      //using spread operator '...'
      //Spread operator, which makes it possible for us to add multiple values to a collection. This collection can be a list, a set, or a map. This operator is a replacement for add or addAll operator in dart.
      state = [...state, meal];
      return true;
    }
  }
}

final favoritesMealProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});
// this StateNotifierProvider class works with another class StateNotifier class