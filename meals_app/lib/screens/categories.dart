import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.onToggleMealFavoriteStatus,
    required this.filters,
  });

  final void Function(String) onToggleMealFavoriteStatus;
  final Map<Filter, bool> filters;

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = dummyMeals
        .where(
          (meal) =>
              meal.categories.contains(category.id) &&
              (meal.isGlutenFree || !filters[Filter.glutenFree]!) &&
              (meal.isLactoseFree || !filters[Filter.lactoseFree]!) &&
              (meal.isVegetarian || !filters[Filter.vegetarian]!) &&
              (meal.isVegan || !filters[Filter.vegan]!),
        )
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
          onToggleMealFavoriteStatus: onToggleMealFavoriteStatus,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.all(18),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      children: [
        for (Category category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () {
              _selectCategory(context, category);
            },
          ),
      ],
    );
  }
}
