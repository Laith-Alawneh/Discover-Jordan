import 'package:flutter/material.dart';

import '../widgets/glass_card.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Discover Jordan', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              const Text(
                'This premium tourism app showcases Jordanian destinations, promotes cultural education, and provides an engaging digital visitor experience.',
              ),
              const SizedBox(height: 10),
              const Text(
                'Developed for BTEC Level 3 IT Unit 7 with modern UI/UX principles, responsive architecture, and local-first functionality.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
