import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  void _selectCategory(BuildContext context, Category category, WidgetRef ref) {
    final filteredMeals = ref
        .watch(filteredMealsProvider)
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              _selectCategory(context, category, ref);
            },
          ),
      ],
    );
  }
}
