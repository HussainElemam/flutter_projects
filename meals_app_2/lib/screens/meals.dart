import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
  });

  final String? title;
  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    Widget content = meals.isEmpty
        ? Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Un no ... nothing here!',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Try selectign a different category',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          )
        : ListView.builder(
            itemBuilder: (ctx, index) => MealItem(
              meal: meals[index],
            ),
            itemCount: meals.length,
          );

    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
