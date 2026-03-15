import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/quiz_provider.dart';
import '../services/audio_service.dart';
import '../widgets/glass_card.dart';

final _audioProvider = Provider<AudioService>((ref) => AudioService());

class QuizScreen extends ConsumerWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quizProvider);
    final questions = ref.watch(quizQuestionsProvider);
    final notifier = ref.read(quizProvider.notifier);

    if (state.isComplete) {
      final reviewItems = List.generate(questions.length, (index) {
        final question = questions[index];
        final selectedAnswer = state.selectedAnswers[index];
        final isCorrect = selectedAnswer != null && selectedAnswer == question.correctOption;
        return (index, question, selectedAnswer, isCorrect);
      });

      return Scaffold(
        appBar: AppBar(title: const Text('نتيجة الاختبار')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            GlassCard(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0.6, end: 1),
                      duration: const Duration(milliseconds: 500),
                      builder: (context, value, child) => Transform.scale(scale: value, child: child),
                      child: Text(
                        '${state.score}/${questions.length}',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.score >= 3 ? 'أحسنت! نتيجتك ممتازة.' : 'استمر، أنت تتحسن.',
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: notifier.restart,
                        child: const Text('إعادة الاختبار'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            ...reviewItems.map((item) {
              final index = item.$1;
              final question = item.$2;
              final selectedAnswer = item.$3;
              final isCorrect = item.$4;
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: (isCorrect ? Colors.green : Colors.red).withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: (isCorrect ? Colors.green : Colors.red).withValues(alpha: 0.35),
                    ),
                  ),
                  child: ListTile(
                    title: Text('س${index + 1}. ${question.question}'),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'إجابتك: ${selectedAnswer == null ? "لم يتم اختيار إجابة" : question.options[selectedAnswer]}',
                            style: TextStyle(
                              color: selectedAnswer == null
                                  ? Theme.of(context).colorScheme.onSurfaceVariant
                                  : (isCorrect ? Colors.green.shade800 : Colors.red.shade800),
                            ),
                          ),
                          if (!isCorrect)
                            Text(
                              'الإجابة الصحيحة: ${question.options[question.correctOption]}',
                              style: TextStyle(color: Colors.green.shade800),
                            ),
                        ],
                      ),
                    ),
                    trailing: Icon(
                      isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
                      color: isCorrect ? Colors.green : Colors.red,
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      );
    }

    final current = questions[state.currentIndex];
    final selected = state.selectedAnswers[state.currentIndex];
    final showEvaluation = selected != null;
    return Scaffold(
      appBar: AppBar(
        title: Text('السؤال ${state.currentIndex + 1}/${questions.length}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(current.question, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              ...List.generate(current.options.length, (index) {
                final isCorrect = index == current.correctOption;
                final isSelected = selected == index;
                final isWrongSelection = showEvaluation && isSelected && !isCorrect;
                final showCorrect = showEvaluation && isCorrect;
                final background = showCorrect
                    ? const Color(0xFF1B8A4E).withValues(alpha: 0.16)
                    : isWrongSelection
                        ? const Color(0xFFB71C1C).withValues(alpha: 0.16)
                        : Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.4);
                final border = showCorrect
                    ? const Color(0xFF1B8A4E)
                    : isWrongSelection
                        ? const Color(0xFFB71C1C)
                        : Theme.of(context).colorScheme.outlineVariant;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOut,
                    decoration: BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: border),
                    ),
                    child: ListTile(
                      title: Text(current.options[index]),
                      trailing: showCorrect
                          ? const Icon(Icons.check_circle_rounded, color: Color(0xFF1B8A4E))
                          : isWrongSelection
                              ? const Icon(Icons.cancel_rounded, color: Color(0xFFB71C1C))
                              : null,
                      onTap: showEvaluation
                          ? null
                          : () async {
                              notifier.selectAnswer(index);
                              if (index == current.correctOption) {
                                await ref.read(_audioProvider).playCorrectAnswer();
                              }
                            },
                    ),
                  ),
                );
              }),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: showEvaluation ? notifier.nextQuestion : null,
                  icon: const Icon(Icons.arrow_forward_rounded),
                  label: Text(state.currentIndex == questions.length - 1 ? 'إنهاء الاختبار' : 'التالي'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
