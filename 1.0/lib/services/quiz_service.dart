class QuizService {
  const QuizService();

  int computeScore({
    required List<int?> selectedAnswers,
    required List<int> correctAnswers,
  }) {
    var score = 0;
    for (var i = 0; i < correctAnswers.length; i++) {
      if (selectedAnswers[i] != null && selectedAnswers[i] == correctAnswers[i]) {
        score++;
      }
    }
    return score;
  }
}
