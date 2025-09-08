import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary({super.key, required this.summaryData});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map((item) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: item['user_answer'] == item['correct_answer']
                        ? const Color.fromARGB(255, 57, 171, 232)
                        : const Color.fromARGB(255, 221, 35, 235),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${(item['question_index'] as int) + 1}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['question'] as String,
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        item['user_answer'] as String,
                        style: TextStyle(
                          color: Color.fromARGB(255, 166, 101, 241),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        item['correct_answer'] as String,
                        style: TextStyle(
                          color: Color.fromARGB(255, 87, 153, 238),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
