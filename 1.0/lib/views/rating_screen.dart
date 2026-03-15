import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibration/vibration.dart';

import '../providers/rating_provider.dart';
import '../services/audio_service.dart';
import '../widgets/glass_card.dart';
import '../widgets/star_rating_bar.dart';

final _audioProvider = Provider<AudioService>((ref) => AudioService());

class RatingScreen extends ConsumerStatefulWidget {
  const RatingScreen({super.key});

  @override
  ConsumerState<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends ConsumerState<RatingScreen> {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    final savedRating = ref.watch(ratingProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Rate App')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GlassCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('How would you rate your experience?', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              StarRatingBar(
                rating: _rating,
                onChanged: (value) async {
                  setState(() => _rating = value);
                  if (value >= 4) {
                    await ref.read(_audioProvider).playApplause();
                    final canVibrate = await Vibration.hasVibrator();
                    if (canVibrate ?? false) {
                      await Vibration.vibrate(duration: 120);
                    }
                  }
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _rating == 0
                    ? null
                    : () async {
                        await ref.read(ratingProvider.notifier).saveRating(_rating);
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Rating saved locally')),
                          );
                        }
                      },
                child: const Text('Save Rating'),
              ),
              const SizedBox(height: 14),
              savedRating.when(
                data: (value) => Text('Saved rating: ${value ?? "none"}'),
                loading: () => const CircularProgressIndicator(),
                error: (_, _) => const Text('Unable to load saved rating'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
