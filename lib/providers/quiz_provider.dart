import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/quiz_question.dart';
import '../services/quiz_service.dart';

final quizQuestionsProvider = Provider<List<QuizQuestion>>((ref) {
  return const [
    QuizQuestion(
      question: 'ما المدينة الأردنية المعروفة باسم المدينة الوردية؟',
      options: ['العقبة', 'البتراء', 'جرش', 'مادبا'],
      correctOption: 1,
    ),
    QuizQuestion(
      question: 'أي منطقة صحراوية في الأردن تشتهر بمشاهدة النجوم؟',
      options: ['وادي رم', 'عجلون', 'إربد', 'الزرقاء'],
      correctOption: 0,
    ),
    QuizQuestion(
      question: 'ما الميزة الفريدة للبحر الميت؟',
      options: [
        'هو أعلى بحر في العالم',
        'لا يحتوي على أملاح',
        'هو أخفض نقطة على سطح اليابسة',
        'هو بحيرة مياه عذبة',
      ],
      correctOption: 2,
    ),
    QuizQuestion(
      question: 'أي وجهة في الأردن تشتهر بالآثار الرومانية؟',
      options: ['جرش', 'العقبة', 'الكرك', 'السلط'],
      correctOption: 0,
    ),
    QuizQuestion(
      question: 'أي مدينة أردنية تقع على ساحل البحر الأحمر؟',
      options: ['البتراء', 'العقبة', 'جرش', 'المفرق'],
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

  factory QuizState.initial(int totalQuestions) {
    return QuizState(
      currentIndex: 0,
      selectedAnswers: List<int?>.filled(totalQuestions, null),
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
    final questions = ref.read(quizQuestionsProvider);
    return QuizState.initial(questions.length);
  }

  void selectAnswer(int answerIndex) {
    if (state.isComplete) {
      return;
    }
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
    final total = ref.read(quizQuestionsProvider).length;
    state = QuizState.initial(total);
  }
}

final quizProvider = NotifierProvider<QuizNotifier, QuizState>(QuizNotifier.new);
