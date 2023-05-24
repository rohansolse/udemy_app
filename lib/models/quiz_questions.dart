class QuizQuestion {
  const QuizQuestion(this.text, this.answers);

  final String text;
  final List<String> answers;

  List<String> get shuffledAnswers {
    final shuffedAnswers = List.of(answers);
    shuffedAnswers.shuffle();
    return shuffedAnswers;
  }
}
