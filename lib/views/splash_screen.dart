import 'package:flutter/material.dart';

import '../widgets/animated_gradient_background.dart';
import '../widgets/page_transitions.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))..forward();
    Future<void>.delayed(const Duration(milliseconds: 2200), () {
      if (!mounted) {
        return;
      }
      Navigator.of(context).pushReplacement(fadeSlideRoute(const HomeScreen()));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedGradientBackground(
        child: Center(
          child: FadeTransition(
            opacity: CurvedAnimation(parent: _controller, curve: Curves.easeIn),
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.86, end: 1).animate(
                CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.travel_explore_rounded, size: 86, color: Colors.white),
                  const SizedBox(height: 16),
                  Text(
                    'اكتشف الأردن',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'تجربة سياحية مميزة',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
