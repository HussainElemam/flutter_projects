import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/filters_provider.dart';
import 'package:meals_app/providers/meals_provider.dart';

class FavoriteMealsNotifier extends StateNotifier<Set<String>> {
  FavoriteMealsNotifier() : super({});

  bool toggleMealFavoriteStatus(String mealId) {
    if (state.contains(mealId)) {
      state = state.where((id) => id != mealId).toSet();
      return false;
    } else {
      state = {...state, mealId};
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, Set<String>>(
      (ref) => FavoriteMealsNotifier(),
    );

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final filters = ref.watch(filtersProvider);

  return meals
      .where(
        (meal) =>
            (meal.isGlutenFree || !filters[Filter.glutenFree]!) &&
            (meal.isLactoseFree || !filters[Filter.lactoseFree]!) &&
            (meal.isVegetarian || !filters[Filter.vegetarian]!) &&
            (meal.isVegan || !filters[Filter.vegan]!),
      )
      .toList();
});
