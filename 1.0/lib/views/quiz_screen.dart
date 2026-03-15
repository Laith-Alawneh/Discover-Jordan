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
      return Scaffold(
        appBar: AppBar(title: const Text('Quiz Result')),
        body: Center(
          child: GlassCard(
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
                  const Text('Great effort exploring Jordan!'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: notifier.restart,
                    child: const Text('Restart Quiz'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    final current = questions[state.currentIndex];
    final selected = state.selectedAnswers[state.currentIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${state.currentIndex + 1}/${questions.length}'),
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
                final isSelected = selected == index;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOut,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primaryContainer
                          : Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.outlineVariant,
                      ),
                    ),
                    child: ListTile(
                      title: Text(current.options[index]),
                      onTap: () async {
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
                  onPressed: selected == null ? null : notifier.nextQuestion,
                  icon: const Icon(Icons.arrow_forward_rounded),
                  label: Text(state.currentIndex == questions.length - 1 ? 'Finish Quiz' : 'Next'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
