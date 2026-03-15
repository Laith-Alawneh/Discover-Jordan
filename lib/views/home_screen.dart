import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/attractions_provider.dart';
import '../widgets/animated_gradient_background.dart';
import '../widgets/glass_card.dart';
import '../widgets/intro_video_player.dart';
import '../widgets/page_transitions.dart';
import 'about_screen.dart';
import 'attractions_screen.dart';
import 'favorites_screen.dart';
import 'quiz_screen.dart';
import 'rating_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTablet = MediaQuery.sizeOf(context).width >= 700;
    final attractionCount = ref.watch(attractionsProvider).length;
    return Scaffold(
      body: AnimatedGradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('استكشف الأردن', style: Theme.of(context).textTheme.displaySmall),
                    const SizedBox(height: 8),
                    Text(
                      'التاريخ والثقافة والرحلات المميزة في تطبيق واحد.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _StatChip(icon: Icons.place_rounded, label: '$attractionCount وجهة'),
                        const _StatChip(icon: Icons.auto_awesome_rounded, label: 'واجهة عصرية'),
                        const _StatChip(icon: Icons.offline_pin_rounded, label: 'يعمل بدون إنترنت'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const IntroVideoPlayer(),
                    const SizedBox(height: 20),
                    GlassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('اكتشف', style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 12),
                          Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          SizedBox(
                            width: isTablet ? 260 : double.infinity,
                            child: _MenuCard(
                              title: 'المعالم السياحية',
                              subtitle: 'البتراء ووادي رم والبحر الميت وغيرها',
                              icon: Icons.landscape_rounded,
                              onTap: () => Navigator.of(context).push(
                                fadeSlideRoute(const AttractionsScreen()),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: isTablet ? 260 : double.infinity,
                            child: _MenuCard(
                              title: 'الاختبار',
                              subtitle: 'اختبر معلوماتك عن الأردن',
                              icon: Icons.quiz_rounded,
                              onTap: () => Navigator.of(context).push(
                                fadeSlideRoute(const QuizScreen()),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: isTablet ? 260 : double.infinity,
                            child: _MenuCard(
                              title: 'تقييم التطبيق',
                              subtitle: 'شارك رأيك واحفظ تقييمك',
                              icon: Icons.star_rounded,
                              onTap: () => Navigator.of(context).push(
                                fadeSlideRoute(const RatingScreen()),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: isTablet ? 260 : double.infinity,
                            child: _MenuCard(
                              title: 'المفضلة',
                              subtitle: 'الأماكن التي حفظتها',
                              icon: Icons.favorite_rounded,
                              onTap: () => Navigator.of(context).push(
                                fadeSlideRoute(const FavoritesScreen()),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: isTablet ? 260 : double.infinity,
                            child: _MenuCard(
                              title: 'حول التطبيق',
                              subtitle: 'الهدف والجودة وخطة التطوير',
                              icon: Icons.info_rounded,
                              onTap: () => Navigator.of(context).push(
                                fadeSlideRoute(const AboutScreen()),
                              ),
                            ),
                          ),
                        ],
                      ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14),
          const SizedBox(width: 6),
          Text(label),
        ],
      ),
    );
  }
}

class _MenuCard extends StatefulWidget {
  const _MenuCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  State<_MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<_MenuCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 120),
        scale: _pressed ? 0.98 : 1,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.95),
                Theme.of(context).colorScheme.secondaryContainer.withValues(alpha: 0.95),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: _pressed ? 4 : 14,
                offset: Offset(0, _pressed ? 3 : 8),
              ),
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.surface.withValues(alpha: 0.7),
                child: Icon(widget.icon),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title, style: Theme.of(context).textTheme.titleMedium),
                    Text(widget.subtitle, style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded, size: 14),
            ],
          ),
        ),
      ),
    );
  }
}
