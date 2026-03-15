import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_tour/services/rating_service.dart';

void main() {
  group('RatingService', () {
    test('saveRating persists value and getRating retrieves it', () async {
      SharedPreferences.setMockInitialValues({});
      final service = RatingService();
      await service.saveRating(4);
      final loaded = await service.getRating();
      expect(loaded, 4);
    });
  });
}
