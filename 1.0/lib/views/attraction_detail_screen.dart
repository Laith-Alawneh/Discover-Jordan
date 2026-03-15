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
                        child: Image.network(attraction.imageUrl, fit: BoxFit.cover),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Cultural & Historical Context', style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 8),
                          Text(attraction.description),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text('Gallery', style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 200,
                      child: PageView.builder(
                        itemCount: attraction.galleryUrls.length,
                        controller: PageController(viewportFraction: 0.9),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(attraction.galleryUrls[index], fit: BoxFit.cover),
                            ),
                          );
                        },
                      ),
                    ),
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
