import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/attractions_provider.dart';
import '../widgets/glass_card.dart';
import '../widgets/page_transitions.dart';
import 'attraction_detail_screen.dart';

class AttractionsScreen extends ConsumerWidget {
  const AttractionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attractions = ref.watch(attractionsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Top Attractions')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: attractions.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final attraction = attractions[index];
          return GestureDetector(
            onTap: () => Navigator.of(context).push(fadeSlideRoute(AttractionDetailScreen(attraction: attraction))),
            child: GlassCard(
              padding: EdgeInsets.zero,
              child: Row(
                children: [
                  Hero(
                    tag: attraction.heroTag,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.horizontal(left: Radius.circular(20)),
                      child: Image.network(
                        attraction.imageUrl,
                        width: 130,
                        height: 130,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(attraction.title, style: Theme.of(context).textTheme.titleLarge),
                          Text(attraction.location, style: Theme.of(context).textTheme.bodyMedium),
                          const SizedBox(height: 8),
                          Text(
                            attraction.summary,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.arrow_forward_ios_rounded, size: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
