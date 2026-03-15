import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/quiz_question.dart';
import '../services/quiz_service.dart';

final quizQuestionsProvider = Provider<List<QuizQuestion>>((ref) {
  return const [
    QuizQuestion(
      question: 'Which city in Jordan is known as the Rose City?',
      options: ['Aqaba', 'Petra', 'Jerash', 'Madaba'],
      correctOption: 1,
    ),
    QuizQuestion(
      question: 'Which desert landscape in Jordan is famous for stargazing?',
      options: ['Wadi Rum', 'Ajloun', 'Irbid', 'Zarqa'],
      correctOption: 0,
    ),
    QuizQuestion(
      question: 'What is unique about the Dead Sea?',
      options: [
        'It is the highest sea in the world',
        'It has no salt',
        'It is the lowest point on land',
        'It is a freshwater lake',
      ],
      correctOption: 2,
    ),
    QuizQuestion(
      question: 'Which destination is best known for Roman ruins in Jordan?',
      options: ['Jerash', 'Aqaba', 'Karak', 'Salt'],
      correctOption: 0,
    ),
    QuizQuestion(
      question: 'Which Jordanian city is located on the Red Sea coast?',
      options: ['Petra', 'Aqaba', 'Jerash', 'Mafraq'],
      correctOption: 1,
    ),
  ];
});

final quizServiceProvider = Provider<QuizService>((ref) => const QuizService());

class QuizState {
  const QuizState({
    required this.currentIndex,
    required this.selectedAnswers,
    required this.isComplete,
    required this.score,
  });

  factory QuizState.initial(int total) {
    return QuizState(
      currentIndex: 0,
      selectedAnswers: List<int?>.filled(total, null),
      isComplete: false,
      score: 0,
    );
  }

  final int currentIndex;
  final List<int?> selectedAnswers;
  final bool isComplete;
  final int score;

  QuizState copyWith({
    int? currentIndex,
    List<int?>? selectedAnswers,
    bool? isComplete,
    int? score,
  }) {
    return QuizState(
      currentIndex: currentIndex ?? this.currentIndex,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      isComplete: isComplete ?? this.isComplete,
      score: score ?? this.score,
    );
  }
}

class QuizNotifier extends Notifier<QuizState> {
  @override
  QuizState build() {
    return QuizState.initial(ref.read(quizQuestionsProvider).length);
  }

  void selectAnswer(int answerIndex) {
    final updated = [...state.selectedAnswers];
    updated[state.currentIndex] = answerIndex;
    state = state.copyWith(selectedAnswers: updated);
  }

  void nextQuestion() {
    final questions = ref.read(quizQuestionsProvider);
    if (state.currentIndex < questions.length - 1) {
      state = state.copyWith(currentIndex: state.currentIndex + 1);
      return;
    }
    final score = ref.read(quizServiceProvider).computeScore(
          selectedAnswers: state.selectedAnswers,
          correctAnswers: questions.map((q) => q.correctOption).toList(),
        );
    state = state.copyWith(isComplete: true, score: score);
  }

  void restart() {
    state = QuizState.initial(ref.read(quizQuestionsProvider).length);
  }
}

final quizProvider = NotifierProvider<QuizNotifier, QuizState>(QuizNotifier.new);
