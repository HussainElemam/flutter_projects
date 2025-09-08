import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_summary.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.choosenAnswers,
    required this.restartQuiz,
  });

  final List<String> choosenAnswers;
  final void Function() restartQuiz;

  List<Map<String, Object>> get summaryData {
    return [
      for (int i = 0; i < choosenAnswers.length; ++i)
        {
          'question_index': i,
          'question': questions[i].text,
          'correct_answer': questions[i].answers[0],
          'user_answer': choosenAnswers[i],
        },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final numTotalQuestions = choosenAnswers.length;
    final numCorrectQuestions = summaryData
        .where(
          (element) => element['correct_answer'] == element['user_answer'],
        )
        .length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: const Color.fromARGB(255, 201, 136, 241),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            QuestionsSummary(summaryData: summaryData),
            SizedBox(height: 30),
            TextButton.icon(
              onPressed: restartQuiz,
              style: TextButton.styleFrom(
                textStyle: TextStyle(fontSize: 18),
                foregroundColor: Color.fromARGB(255, 238, 214, 253),
              ),
              icon: Icon(
                Icons.refresh,
                size: 28,
              ),
              label: Text('Restart Quiz!'),
            ),
          ],
        ),
      ),
    );
  }
}
