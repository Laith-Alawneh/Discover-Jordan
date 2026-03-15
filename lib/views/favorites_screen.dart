import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/attractions_provider.dart';
import '../providers/favorites_provider.dart';
import '../widgets/glass_card.dart';
import '../widgets/page_transitions.dart';
import 'attraction_detail_screen.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attractions = ref.watch(attractionsProvider);
    final favoriteIds = ref.watch(favoritesProvider).valueOrNull ?? <String>{};
    final favorites = attractions.where((item) => favoriteIds.contains(item.id)).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('المعالم المفضلة')),
      body: favorites.isEmpty
          ? const Center(child: Text('لا توجد معالم مفضلة بعد. اضغط على القلب لإضافتها.'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: favorites.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final attraction = favorites[index];
                return GestureDetector(
                  onTap: () => Navigator.of(context).push(fadeSlideRoute(AttractionDetailScreen(attraction: attraction))),
                  child: GlassCard(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            attraction.imageAsset,
                            width: 72,
                            height: 72,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              width: 72,
                              height: 72,
                              color: Theme.of(context).colorScheme.surfaceContainerHighest,
                              alignment: Alignment.center,
                              child: const Icon(Icons.image_not_supported_rounded),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            attraction.title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        IconButton(
                          onPressed: () => ref.read(favoritesProvider.notifier).toggle(attraction.id),
                          icon: const Icon(Icons.delete_outline_rounded),
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
