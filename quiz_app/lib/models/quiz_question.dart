class QuizQuestion {
  const QuizQuestion(this.text, this.answers);

  final String text;
  final List<String> answers;

  List<String> get shuffledAnswers {
    final shuffuledAnswers = List.of(answers);
    shuffuledAnswers.shuffle();
    return shuffuledAnswers;
  }
}
