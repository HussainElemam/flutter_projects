import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/results_screen.dart';

import 'package:quiz_app/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  final List<String> selectedAnswers = [];
  Widget? activeScreen;

  @override
  void initState() {
    super.initState();
    activeScreen = StartScreen(startQuiz);
  }

  void chooseAnswer(String choosenAnwser) {
    selectedAnswers.add(choosenAnwser);

    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = ResultsScreen(
          choosenAnswers: selectedAnswers,
          restartQuiz: startQuiz,
        );
      });
    }
  }

  void startQuiz() {
    setState(() {
      selectedAnswers.clear();
      activeScreen = QuestionsScreen(onSelectAnswer: chooseAnswer);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 64, 7, 138),
                const Color.fromARGB(255, 88, 13, 155),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: activeScreen,
        ),
      ),
    );
  }
}
