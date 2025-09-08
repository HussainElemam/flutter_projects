import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, {super.key});

  final void Function() startQuiz;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/quiz-logo.png",
            width: 300,
            color: const Color.fromARGB(114, 255, 255, 255),
          ),
          SizedBox(
            height: 80,
          ),
          Text(
            'Learn Flutter the fun way!',
            style: GoogleFonts.lato(
              color: const Color.fromARGB(255, 238, 210, 247),
              fontSize: 24,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              // textStyle: TextStyle(fontSize: 28),
            ),
            onPressed: startQuiz,
            icon: Icon(Icons.arrow_right_alt),
            label: Text('Start Quiz'),
          ),
        ],
      ),
    );
  }
}
