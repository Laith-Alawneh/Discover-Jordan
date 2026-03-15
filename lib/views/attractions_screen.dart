import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/attractions_provider.dart';
import '../providers/favorites_provider.dart';
import '../widgets/glass_card.dart';
import '../widgets/page_transitions.dart';
import 'attraction_detail_screen.dart';
import 'favorites_screen.dart';

class AttractionsScreen extends ConsumerWidget {
  const AttractionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attractions = ref.watch(attractionsProvider);
    final favorites = ref.watch(favoritesProvider).valueOrNull ?? <String>{};
    return Scaffold(
      appBar: AppBar(
        title: const Text('أهم المعالم السياحية'),
        actions: [
          IconButton(
            tooltip: 'المفضلة',
            onPressed: () => Navigator.of(context).push(
              fadeSlideRoute(const FavoritesScreen()),
            ),
            icon: Badge.count(
              count: favorites.length,
              isLabelVisible: favorites.isNotEmpty,
              child: const Icon(Icons.favorite_rounded),
            ),
          ),
        ],
      ),
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
                      child: Image.asset(
                        attraction.imageAsset,
                        width: 130,
                        height: 130,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 130,
                            height: 130,
                            color: Theme.of(context).colorScheme.surfaceContainerHigh,
                            alignment: Alignment.center,
                            child: const Icon(Icons.image_not_supported_rounded),
                          );
                        },
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
                  IconButton(
                    onPressed: () => ref.read(favoritesProvider.notifier).toggle(attraction.id),
                    icon: Icon(
                      favorites.contains(attraction.id)
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: favorites.contains(attraction.id) ? Colors.red : null,
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
