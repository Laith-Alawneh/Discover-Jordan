import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/animated_gradient_background.dart';
import '../widgets/glass_card.dart';
import '../widgets/intro_video_player.dart';
import '../widgets/neumorphic_button.dart';
import '../widgets/page_transitions.dart';
import 'about_screen.dart';
import 'attractions_screen.dart';
import 'quiz_screen.dart';
import 'rating_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTablet = MediaQuery.sizeOf(context).width >= 700;
    return Scaffold(
      body: AnimatedGradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Explore Jordan', style: Theme.of(context).textTheme.displaySmall),
                    const SizedBox(height: 8),
                    Text(
                      'History, culture, and premium journeys in one mobile experience.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 20),
                    const IntroVideoPlayer(),
                    const SizedBox(height: 20),
                    GlassCard(
                      child: Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          SizedBox(
                            width: isTablet ? 200 : double.infinity,
                            child: NeumorphicButton(
                              label: 'Attractions',
                              icon: Icons.landscape_rounded,
                              onTap: () => Navigator.of(context).push(fadeSlideRoute(const AttractionsScreen())),
                            ),
                          ),
                          SizedBox(
                            width: isTablet ? 200 : double.infinity,
                            child: NeumorphicButton(
                              label: 'Quiz',
                              icon: Icons.quiz_rounded,
                              onTap: () => Navigator.of(context).push(fadeSlideRoute(const QuizScreen())),
                            ),
                          ),
                          SizedBox(
                            width: isTablet ? 200 : double.infinity,
                            child: NeumorphicButton(
                              label: 'Rate App',
                              icon: Icons.star_rounded,
                              onTap: () => Navigator.of(context).push(fadeSlideRoute(const RatingScreen())),
                            ),
                          ),
                          SizedBox(
                            width: isTablet ? 200 : double.infinity,
                            child: NeumorphicButton(
                              label: 'About',
                              icon: Icons.info_rounded,
                              onTap: () => Navigator.of(context).push(fadeSlideRoute(const AboutScreen())),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
