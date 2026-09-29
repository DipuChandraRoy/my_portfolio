import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../widgets/section_title.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Projects Section
// ─────────────────────────────────────────────────────────────────────────────

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  static const List<_ProjectData> _projects = [
    _ProjectData(
      title: 'E-Commerce Mobile Application',
      description:
          'A full-featured shopping application with product browsing, cart management, '
          'secure payment integration, and real-time order tracking built with Flutter, '
          'REST APIs, and Provider state management.',
      tags: ['Flutter', 'REST APIs', 'Provider'],
      icon: Icons.shopping_bag_rounded,
    ),
    _ProjectData(
      title: 'Rose Leaf Disease Detection',
      description:
          'An intelligent plant health app that uses an on-device TensorFlow Lite model '
          'to detect and classify rose leaf diseases from camera images in real time, '
          'with no internet connection required.',
      tags: ['Flutter', 'TensorFlow Lite', 'ML'],
      icon: Icons.local_florist_rounded,
    ),
    _ProjectData(
      title: 'Personal Fitness Tracking App',
      description:
          'A health & fitness application featuring custom widget animations, workout '
          'logging, progress tracking, and goal setting — built entirely with Flutter '
          'custom widgets and local data persistence.',
      tags: ['Flutter', 'Custom Widgets', 'SQLite'],
      icon: Icons.fitness_center_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 800;
          final isMedium = constraints.maxWidth >= 550;

          int crossAxisCount = 1;
          if (isWide) {
            crossAxisCount = 3;
          } else if (isMedium) {
            crossAxisCount = 2;
          }

          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              padding: EdgeInsets.symmetric(horizontal: isWide ? 60 : 24),
              child: Column(
                children: [
                  const SectionTitle(
                    title: 'Projects',
                    subtitle: 'Some of my recent works',
                  ),
                  const SizedBox(height: 50),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      mainAxisExtent: 340,
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
