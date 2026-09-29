import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../widgets/section_title.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Services Section
// ─────────────────────────────────────────────────────────────────────────────

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  static const List<_ServiceData> _services = [
    _ServiceData(
      icon: Icons.phone_android_rounded,
      title: 'Flutter App Development',
      description:
          'Building high-performance, cross-platform mobile applications for iOS '
          'and Android using Flutter & Dart with native-like experiences and clean architecture.',
    ),
    _ServiceData(
      icon: Icons.design_services_rounded,
      title: 'UI/UX Design',
      description:
          'Designing intuitive, user-centered interfaces — from wireframing and prototyping '
          'to pixel-perfect Flutter implementations using Material Design principles.',
    ),
    _ServiceData(
      icon: Icons.api_rounded,
      title: 'REST API Integration',
      description:
          'Connecting Flutter front-ends with RESTful APIs and external services, '
          'managing asynchronous data flow with robust error handling and optimized calls.',
    ),
    _ServiceData(
      icon: Icons.cloud_rounded,
      title: 'Firebase & Backend',
      description:
          'Setting up Firebase Authentication, Firestore, Cloud Functions, and push notifications '
          'to build scalable, real-time backends for mobile applications.',
    ),
    _ServiceData(
      icon: Icons.psychology_rounded,
      title: 'On-Device AI / ML',
      description:
          'Deploying machine learning models on mobile devices using TensorFlow Lite, '
          'enabling offline-capable intelligent features like image classification and detection.',
    ),
    _ServiceData(
      icon: Icons.tune_rounded,
      title: 'State Management',
      description:
          'Implementing modern state management patterns (Riverpod, Provider) to build '
          'stable, maintainable Flutter apps with optimized performance and clean code structure.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: screenWidth < 500 ? 50 : 80),
      decoration: const BoxDecoration(
        color: Color(0xFF0D0D0D),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 950;
          final isMedium = constraints.maxWidth >= 600;

          int crossAxisCount = 1;
          if (isWide) {
            crossAxisCount = 3;
          } else if (isMedium) {
            crossAxisCount = 2;
          }

          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              padding: EdgeInsets.symmetric(
                horizontal: isWide ? 60 : (constraints.maxWidth < 500 ? 16 : 24),
              ),
              child: Column(
                children: [
                  const SectionTitle(
                    title: 'Services',
                    subtitle: 'What I can do for you',
                  ),
                  const SizedBox(height: 50),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      mainAxisExtent: 290,
                    ),
                    itemCount: _services.length,
                    itemBuilder: (context, index) {
                      return _ServiceCard(data: _services[index]);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ─── Service Data Model ──────────────────────────────────────────────────────

class _ServiceData {
  final IconData icon;
  final String title;
  final String description;

  const _ServiceData({
    required this.icon,
    required this.title,
    required this.description,
  });
}

// ─── Service Card ────────────────────────────────────────────────────────────

class _ServiceCard extends StatefulWidget {
  final _ServiceData data;
  const _ServiceCard({required this.data});

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: _hovered
            ? (Matrix4.identity()..translate(0.0, -6.0))
            : Matrix4.identity(),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered
                ? AppColors.accent.withValues(alpha: 0.5)
                : AppColors.divider,
            width: 1,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.12),
                    blurRadius: 30,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Icon Container ──
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: _hovered
                    ? AppColors.accent
                    : AppColors.accent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                widget.data.icon,
                color: _hovered ? Colors.black : AppColors.accent,
                size: 28,
              ),
            ),
            const SizedBox(height: 20),

            // ── Title ──
            Text(
              widget.data.title,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 12),

            // ── Description ──
            Expanded(
              child: Text(
                widget.data.description,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.grey.withValues(alpha: 0.7),
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
