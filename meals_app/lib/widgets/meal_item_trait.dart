import 'package:flutter/material.dart';

class MealItemTrait extends StatelessWidget {
  MealItemTrait({
    super.key,
    required this.icon,
    required this.lable,
  });

  final IconData icon;
  final String lable;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 17,
          color: Colors.white,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          lable,
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
