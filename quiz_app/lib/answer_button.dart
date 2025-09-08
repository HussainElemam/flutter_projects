import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton({
    super.key,
    required this.answerText,
    required this.onTap,
  });

  final String answerText;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 29, 11, 127),
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 10,
        ),
      ),
      child: Text(
        answerText,
        textAlign: TextAlign.center,
      ),
    );
  }
}
