import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../widgets/section_title.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Projects Section — 8 Featured Projects from Resume
// ─────────────────────────────────────────────────────────────────────────────

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  static const List<_ProjectData> _projects = [
    _ProjectData(
      title: 'Swish - Live Streaming',
      description:
          'Real-time audio and voice rooms, multi-participant video grids, live interactive chat, '
          'virtual gifts, wallet, and diamond coin reward systems built with LiveKit and WebSocket.',
      tags: ['Flutter', 'Riverpod', 'Dio', 'WebSocket', 'LiveKit'],
      icon: Icons.live_tv_rounded,
    ),
    _ProjectData(
      title: 'Safollo Bazar - Customer App',
      description:
          'Comprehensive e-commerce mobile shopping experience featuring dynamic product catalogs, '
          'cart management, checkout, order tracking, and account dashboard modules.',
      tags: ['Flutter', 'GetX', 'REST APIs'],
      icon: Icons.shopping_bag_rounded,
    ),
    _ProjectData(
      title: 'Safollo Bazar - Rider App',
      description:
          'Dedicated order delivery and rider workflow application featuring live location tracking, '
          'online/offline availability status, instant order notifications, and route management.',
      tags: ['Flutter', 'GetX', 'REST APIs', 'Location'],
      icon: Icons.delivery_dining_rounded,
    ),
    _ProjectData(
      title: 'SportsBD - Cricket App',
      description:
          'Feature-rich sports application providing live ball-by-ball commentary, real-time match scores, '
          'team schedules, player profiles, and detailed tournament statistics.',
      tags: ['Flutter', 'Riverpod', 'REST APIs'],
      icon: Icons.sports_cricket_rounded,
    ),
    _ProjectData(
      title: 'eTicketMart / Tricket',
      description:
          'Online ticketing and travel booking application with API-driven bus/train schedules, '
          'interactive seat selection, secured payment gateways, and booking confirmations.',
      tags: ['Flutter', 'Riverpod', 'REST APIs'],
      icon: Icons.confirmation_number_rounded,
    ),
    _ProjectData(
      title: 'KheloBD - Esports Platform',
      description:
          'Competitive esports and gaming tournament platform featuring match registrations, '
          'player team profiles, tournament bracket tracking, and API-connected leaderboards.',
      tags: ['Flutter', 'GetX', 'REST APIs'],
      icon: Icons.sports_esports_rounded,
    ),
    _ProjectData(
      title: 'Rose Leaf Disease Detection App',
      description:
          'Intelligent agriculture application using an on-device TensorFlow Lite machine learning model '
          'to diagnose rose leaf diseases in real-time from camera photos without internet.',
      tags: ['Flutter', 'TensorFlow Lite', 'AI/ML'],
      icon: Icons.local_florist_rounded,
    ),
    _ProjectData(
      title: 'Personal Fitness Tracking App',
      description:
          'Personal health and fitness tracking application featuring custom widget animations, '
          'daily workout logging, calorie & step tracking, and local SQLite data persistence.',
      tags: ['Flutter', 'Custom Widgets', 'SQLite'],
      icon: Icons.fitness_center_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: screenWidth < 500 ? 50 : 80),
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
                horizontal:
                    isWide ? 60 : (constraints.maxWidth < 500 ? 16 : 24),
              ),
              child: Column(
                children: [
                  const SectionTitle(
                    title: 'Projects',
                    subtitle: 'Featured applications and platforms I built',
                  ),
                  const SizedBox(height: 50),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      mainAxisExtent: 360,
                    ),
                    itemCount: _projects.length,
                    itemBuilder: (context, index) {
                      return _ProjectCard(data: _projects[index]);
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

// ─── Project Data Model ──────────────────────────────────────────────────────

class _ProjectData {
  final String title;
  final String description;
  final List<String> tags;
  final IconData icon;

  const _ProjectData({
    required this.title,
    required this.description,
    required this.tags,
    required this.icon,
  });
}

// ─── Project Card ────────────────────────────────────────────────────────────

class _ProjectCard extends StatefulWidget {
  final _ProjectData data;
  const _ProjectCard({required this.data});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
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
        padding: const EdgeInsets.all(24),
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
            // ── Icon ──
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                widget.data.icon,
                color: AppColors.accent,
                size: 24,
              ),
            ),
            const SizedBox(height: 18),

            // ── Title ──
            Text(
              widget.data.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 10),

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
            const SizedBox(height: 14),

            // ── Tags ──
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: widget.data.tags.map((tag) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: AppColors.accent.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Text(
                    tag,
                    style: TextStyle(
                      color: AppColors.accent.withValues(alpha: 0.9),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
