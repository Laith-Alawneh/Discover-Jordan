import 'package:flutter/material.dart';

import '../models/attraction.dart';
import '../widgets/glass_card.dart';

class AttractionDetailScreen extends StatefulWidget {
  const AttractionDetailScreen({super.key, required this.attraction});

  final Attraction attraction;

  @override
  State<AttractionDetailScreen> createState() => _AttractionDetailScreenState();
}

class _AttractionDetailScreenState extends State<AttractionDetailScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 700))..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final attraction = widget.attraction;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                final top = constraints.biggest.height;
                final percent = (top / 280).clamp(0.0, 1.0);
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Transform.translate(
                      offset: Offset(0, (1 - percent) * -30),
                      child: Hero(
                        tag: attraction.heroTag,
                        child: Image.asset(
                          attraction.imageAsset,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Theme.of(context).colorScheme.surfaceContainerHigh,
                              alignment: Alignment.center,
                              child: const Icon(Icons.landscape_rounded, size: 58),
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.center,
                          colors: [Colors.black54, Colors.transparent],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            title: Text(attraction.title),
          ),
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: CurvedAnimation(parent: _controller, curve: Curves.easeIn),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GlassCard(
                      child: Row(
                        children: [
                          Expanded(
                            child: _InfoStat(
                              icon: Icons.schedule_rounded,
                              label: 'المدة المقترحة',
                              value: attraction.recommendedDuration,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _InfoStat(
                              icon: Icons.calendar_month_rounded,
                              label: 'أفضل وقت',
                              value: attraction.bestTimeToVisit,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    GlassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('نبذة سريعة', style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 6),
                          Text(attraction.summary),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    GlassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('السياق الثقافي والتاريخي', style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 8),
                          Text(attraction.description),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text('أبرز المعالم داخل الموقع', style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: attraction.highlights
                          .map(
                            (item) => Chip(
                              avatar: const Icon(Icons.place_rounded, size: 16),
                              label: Text(item),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                    Text('أنشطة مقترحة', style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 8),
                    ...attraction.activities.map(
                      (activity) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: GlassCard(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          child: Row(
                            children: [
                              const Icon(Icons.check_circle_rounded, color: Color(0xFF1B8A4E)),
                              const SizedBox(width: 8),
                              Expanded(child: Text(activity)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GlassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('معلومة ممتعة', style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 8),
                          Text(attraction.funFact),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    GlassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('معلومات عملية', style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 8),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.confirmation_number_rounded),
                            title: const Text('معلومات التذاكر'),
                            subtitle: Text(attraction.ticketInfo),
                          ),
                          ...attraction.travelTips.map(
                            (tip) => ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(Icons.lightbulb_rounded, size: 18),
                              title: Text(tip),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text('معرض الصور', style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 200,
                      child: PageView.builder(
                        itemCount: attraction.galleryAssets.length,
                        controller: PageController(viewportFraction: 0.9),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                attraction.galleryAssets[index],
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Theme.of(context).colorScheme.surfaceContainerHigh,
                                    alignment: Alignment.center,
                                    child: const Icon(Icons.broken_image_rounded),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 18),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoStat extends StatelessWidget {
  const _InfoStat({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.45),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18),
          const SizedBox(height: 8),
          Text(label, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
