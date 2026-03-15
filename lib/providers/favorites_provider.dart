import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesNotifier extends AsyncNotifier<Set<String>> {
  static const _key = 'favorite_attraction_ids';

  @override
  Future<Set<String>> build() async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList(_key) ?? <String>[];
    return ids.toSet();
  }

  Future<void> toggle(String attractionId) async {
    final current = {...?state.value};
    if (current.contains(attractionId)) {
      current.remove(attractionId);
    } else {
      current.add(attractionId);
    }
    state = AsyncData(current);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, current.toList());
  }

  bool isFavorite(String attractionId) {
    return state.valueOrNull?.contains(attractionId) ?? false;
  }
}

final favoritesProvider = AsyncNotifierProvider<FavoritesNotifier, Set<String>>(FavoritesNotifier.new);
