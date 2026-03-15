class Attraction {
  const Attraction({
    required this.id,
    required this.title,
    required this.location,
    required this.heroTag,
    required this.imageUrl,
    required this.summary,
    required this.description,
    required this.galleryUrls,
  });

  final String id;
  final String title;
  final String location;
  final String heroTag;
  final String imageUrl;
  final String summary;
  final String description;
  final List<String> galleryUrls;
}
