import 'package:flutter_test/flutter_test.dart';
import 'package:the_tour/services/quiz_service.dart';

void main() {
  group('QuizService', () {
    test('computeScore returns full score when all answers are correct', () {
      const service = QuizService();
      final score = service.computeScore(
        selectedAnswers: [0, 1, 2, 3, 0],
        correctAnswers: [0, 1, 2, 3, 0],
      );
      expect(score, 5);
    });

    test('computeScore ignores null answers and counts only matches', () {
      const service = QuizService();
      final score = service.computeScore(
        selectedAnswers: [0, null, 2, 2, null],
        correctAnswers: [0, 1, 2, 3, 4],
      );
      expect(score, 2);
    });
  });
}
