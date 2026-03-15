import 'package:flutter/material.dart';

import '../widgets/glass_card.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('حول التطبيق')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GlassCard(
          child: ListView(
            shrinkWrap: true,
            children: [
              Text('اكتشف الأردن', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              const Text(
                'تطبيق سياحي مميز صُمم لإبراز الأردن كوجهة عالمية عبر محتوى تفاعلي وتصميم حديث.',
              ),
              const SizedBox(height: 14),
              _infoTile(
                icon: Icons.flag_rounded,
                title: 'الرسالة',
                body: 'الترويج لمعالم الأردن للزوار المحليين والدوليين من خلال تجربة تفاعلية جذابة.',
              ),
              _infoTile(
                icon: Icons.design_services_rounded,
                title: 'نظام التصميم',
                body: 'Glassmorphism وNeumorphism مع تدرجات متحركة وتصميم متجاوب.',
              ),
              _infoTile(
                icon: Icons.engineering_rounded,
                title: 'البنية البرمجية',
                body: 'بنية نظيفة باستخدام Riverpod ومكونات قابلة لإعادة الاستخدام وخدمات محلية.',
              ),
              _infoTile(
                icon: Icons.rocket_launch_rounded,
                title: 'خارطة الطريق',
                body: 'الإصدارات القادمة تشمل الخرائط والحزم دون إنترنت ودعم محتوى ثنائي اللغة.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoTile({
    required IconData icon,
    required String title,
    required String body,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        tileColor: Colors.white.withValues(alpha: 0.08),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(body),
      ),
    );
  }
}
