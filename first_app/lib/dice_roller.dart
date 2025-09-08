import 'dart:math';

import 'package:flutter/material.dart';

final random = Random();

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller> {
  int currentDiceRoll = random.nextInt(6) + 1;

  void rollDice() {
    setState(() {
      currentDiceRoll = random.nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/dice-$currentDiceRoll.png',
          width: 200,
        ),
        TextButton(
          onPressed: rollDice,
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            textStyle: TextStyle(
              fontSize: 28,
            ),
          ),
          child: Text('Roll Dice'),
        ),
      ],
    );
  }
}
