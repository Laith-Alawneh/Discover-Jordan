import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/attraction.dart';

final attractionsProvider = Provider<List<Attraction>>((ref) {
  return const [
    Attraction(
      id: 'petra',
      title: 'Petra',
      location: 'Ma\'an Governorate',
      heroTag: 'hero_petra',
      imageUrl: 'https://images.unsplash.com/photo-1615811008971-3a5fb50f9c22?auto=format&fit=crop&w=1600&q=80',
      summary: 'The iconic Rose City carved into pink sandstone cliffs.',
      description:
          'Petra is one of Jordan\'s most famous historical sites and a UNESCO World Heritage destination.',
      galleryUrls: [
        'https://images.unsplash.com/photo-1593693397690-362cb9666fc2?auto=format&fit=crop&w=1200&q=80',
        'https://images.unsplash.com/photo-1598618443855-232ee0f819f6?auto=format&fit=crop&w=1200&q=80',
      ],
    ),
    Attraction(
      id: 'wadi_rum',
      title: 'Wadi Rum',
      location: 'Aqaba Governorate',
      heroTag: 'hero_wadi',
      imageUrl: 'https://images.unsplash.com/photo-1581798459219-318e76aecc7b?auto=format&fit=crop&w=1600&q=80',
      summary: 'A vast desert valley known for sandstone mountains and red dunes.',
      description: 'Wadi Rum combines natural beauty with adventure and Bedouin culture.',
      galleryUrls: [
        'https://images.unsplash.com/photo-1603112579969-c616530d3dce?auto=format&fit=crop&w=1200&q=80',
        'https://images.unsplash.com/photo-1518976024611-488b9ed4b847?auto=format&fit=crop&w=1200&q=80',
      ],
    ),
    Attraction(
      id: 'dead_sea',
      title: 'Dead Sea',
      location: 'Jordan Rift Valley',
      heroTag: 'hero_dead_sea',
      imageUrl: 'https://images.unsplash.com/photo-1530797197260-6be59f0f3b5f?auto=format&fit=crop&w=1600&q=80',
      summary: 'The world\'s lowest point on land with mineral-rich waters.',
      description: 'The Dead Sea is known for wellness tourism and floating experiences.',
      galleryUrls: [
        'https://images.unsplash.com/photo-1520454974749-611b7248ffdb?auto=format&fit=crop&w=1200&q=80',
        'https://images.unsplash.com/photo-1496436817401-3cc8ed6fa07f?auto=format&fit=crop&w=1200&q=80',
      ],
    ),
    Attraction(
      id: 'jerash',
      title: 'Jerash',
      location: 'Jerash Governorate',
      heroTag: 'hero_jerash',
      imageUrl: 'https://images.unsplash.com/photo-1541417904950-b855846fe074?auto=format&fit=crop&w=1600&q=80',
      summary: 'One of the best-preserved Roman provincial cities.',
      description: 'Jerash offers impressive Roman ruins and educational cultural events.',
      galleryUrls: [
        'https://images.unsplash.com/photo-1524492412937-b28074a5d7da?auto=format&fit=crop&w=1200&q=80',
        'https://images.unsplash.com/photo-1473445361085-b9a07f55608b?auto=format&fit=crop&w=1200&q=80',
      ],
    ),
    Attraction(
      id: 'aqaba',
      title: 'Aqaba',
      location: 'Red Sea Coast',
      heroTag: 'hero_aqaba',
      imageUrl: 'https://images.unsplash.com/photo-1519046904884-53103b34b206?auto=format&fit=crop&w=1600&q=80',
      summary: 'Jordan\'s coastal destination for marine tourism and leisure.',
      description: 'Aqaba provides diving, resorts, and a lively waterfront tourism experience.',
      galleryUrls: [
        'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?auto=format&fit=crop&w=1200&q=80',
        'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=1200&q=80',
      ],
    ),
  ];
});
