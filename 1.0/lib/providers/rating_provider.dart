import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/rating_service.dart';

final ratingServiceProvider = Provider<RatingService>((ref) => RatingService());

class RatingNotifier extends AsyncNotifier<int?> {
  @override
  Future<int?> build() async {
    return ref.read(ratingServiceProvider).getRating();
  }

  Future<void> saveRating(int rating) async {
    state = const AsyncLoading();
    await ref.read(ratingServiceProvider).saveRating(rating);
    state = AsyncData(rating);
  }
}

final ratingProvider = AsyncNotifierProvider<RatingNotifier, int?>(RatingNotifier.new);
