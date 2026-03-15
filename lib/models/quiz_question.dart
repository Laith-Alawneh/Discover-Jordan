class QuizQuestion {
  const QuizQuestion({
    required this.question,
    required this.options,
    required this.correctOption,
  });

  final String question;
  final List<String> options;
  final int correctOption;
}
