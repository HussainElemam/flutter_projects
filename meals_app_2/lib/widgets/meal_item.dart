import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_deatails.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
  });

  final Meal meal;

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => MealDeatailsScreen(
                meal: meal,
              ),
            ),
          );
        },
        child: Stack(
          children: [
            FadeInImage(
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                decoration: BoxDecoration(
                  color: Colors.black54,
                ),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MealItemTrait(
                          icon: Icons.schedule,
                          lable: '${meal.duration} min',
                        ),
                        MealItemTrait(
                          icon: Icons.work,
                          lable: complexityText,
                        ),
                        MealItemTrait(
                          icon: Icons.schedule,
                          lable: affordabilityText,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
