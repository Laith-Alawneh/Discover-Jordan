import 'package:shared_preferences/shared_preferences.dart';

class RatingService {
  static const ratingKey = 'discover_jordan_rating';

  Future<int?> getRating() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(ratingKey);
  }

  Future<void> saveRating(int rating) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(ratingKey, rating);
  }
}
