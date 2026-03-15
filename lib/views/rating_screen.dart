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
  final TextEditingController _feedbackController = TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final savedRating = ref.watch(ratingProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('تقييم التطبيق')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GlassCard(
          child: ListView(
            shrinkWrap: true,
            children: [
              Text('كيف تقيّم تجربتك؟', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(
                'رأيك يساعدنا على تطوير تجربة السياحة في الأردن.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Center(
                child: StarRatingBar(
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
              ),
              const SizedBox(height: 8),
              if (_rating > 0)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: (_rating >= 4 ? Colors.green : Colors.orange).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _rating >= 4 ? 'ممتاز! شكرا على التقييم العالي.' : 'شكرا لك، سنواصل التحسين.',
                  ),
                ),
              const SizedBox(height: 12),
              TextField(
                controller: _feedbackController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'ملاحظات إضافية (اختياري)',
                  hintText: 'اكتب ما أعجبك أو ما يمكن تحسينه.',
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _rating == 0
                      ? null
                      : () async {
                          await ref.read(ratingProvider.notifier).saveRating(_rating);
                        },
                  child: const Text('حفظ التقييم'),
                ),
              ),
              const SizedBox(height: 14),
              savedRating.when(
                data: (value) => Text('التقييم المحفوظ: ${value ?? "لا يوجد"}'),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, _) => const Text('تعذر تحميل التقييم المحفوظ'),
              ),
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 6),
              const ListTile(
                leading: Icon(Icons.check_circle_rounded),
                title: Text('تحسين جودة التطبيق'),
              ),
              const ListTile(
                leading: Icon(Icons.check_circle_rounded),
                title: Text('تطوير المحتوى السياحي بشكل أفضل'),
              ),
              const ListTile(
                leading: Icon(Icons.check_circle_rounded),
                title: Text('مساعدة الزوار على اختيار الوجهات المناسبة'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
