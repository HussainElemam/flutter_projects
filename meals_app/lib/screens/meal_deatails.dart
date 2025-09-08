import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

class MealDeatailsScreen extends StatelessWidget {
  const MealDeatailsScreen({
    super.key,
    required this.meal,
    required this.onToggleMealFavoriteStatus,
  });

  final Meal meal;
  final void Function(String) onToggleMealFavoriteStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              onToggleMealFavoriteStatus(meal.id);
            },
            icon: Icon(Icons.star),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              meal.imageUrl,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            for (final ingredient in meal.ingredients)
              Text(
                ingredient,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                ),
              ),
            SizedBox(
              height: 24,
            ),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            for (final step in meal.steps)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  step,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
