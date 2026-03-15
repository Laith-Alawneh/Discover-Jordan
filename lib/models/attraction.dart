class Attraction {
  const Attraction({
    required this.id,
    required this.title,
    required this.location,
    required this.heroTag,
    required this.imageAsset,
    required this.summary,
    required this.description,
    required this.bestTimeToVisit,
    required this.recommendedDuration,
    required this.ticketInfo,
    required this.highlights,
    required this.activities,
    required this.travelTips,
    required this.funFact,
    required this.galleryAssets,
  });

  final String id;
  final String title;
  final String location;
  final String heroTag;
  final String imageAsset;
  final String summary;
  final String description;
  final String bestTimeToVisit;
  final String recommendedDuration;
  final String ticketInfo;
  final List<String> highlights;
  final List<String> activities;
  final List<String> travelTips;
  final String funFact;
  final List<String> galleryAssets;
}
