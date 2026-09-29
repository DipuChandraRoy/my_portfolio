import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../widgets/section_title.dart';
import '../widgets/fade_slide_in.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Experience & Education Timeline Section
// ─────────────────────────────────────────────────────────────────────────────

class TimelineSection extends StatelessWidget {
  const TimelineSection({super.key});

  static const _experience = [
    _TimelineData(
      title: 'Flutter Developer (Android & iOS)',
      org: 'DeepVers Lab',
      period: 'Present',
      description:
          'Building cross-platform mobile applications for Android & iOS '
          'using Flutter & Dart. Integrating REST APIs and Firebase backend services.',
      icon: Icons.work_rounded,
      isCurrent: true,
    ),
    _TimelineData(
      title: 'Flutter Developer',
      org: 'N. I. Biz Soft',
      period: 'Mar 2026 – Jun 2026',
      description:
          'Developed and maintained responsive cross-platform apps. '
          'Translated design wireframes into high-performance widget trees. '
          'Integrated RESTful APIs and Firebase.',
      icon: Icons.work_outline_rounded,
      isCurrent: false,
    ),
  ];

  static const _education = [
    _TimelineData(
      title: 'B.Sc. in Computer Science & Engineering',
      org: 'Daffodil International University (DIU)',
      period: '2019 – 2023',
      description:
          'Graduated with a focus on software engineering, algorithms, '
          'data structures and mobile application development.',
      icon: Icons.school_rounded,
      isCurrent: false,
    ),
    _TimelineData(
      title: 'Mobile Application Development (Flutter)',
      org: 'BASIS (BITM)',
      period: '2022 · 3 Months (240 Hours)',
      description:
          'Intensive professional training course covering Flutter/Dart, '
          'UI/UX best practices, and deploying apps to Play Store & App Store.',
      icon: Icons.menu_book_rounded,
      isCurrent: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80),
      decoration: const BoxDecoration(color: Color(0xFF0D0D0D)),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 800;
          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              padding: EdgeInsets.symmetric(horizontal: isWide ? 60 : 24),
              child: Column(
                children: [
                  const FadeSlideIn(
                    child: SectionTitle(
                      title: 'Experience & Education',
                      subtitle: 'My professional journey',
                    ),
                  ),
                  const SizedBox(height: 50),
                  if (isWide)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _TimelineColumn(
                            label: '💼  Work Experience',
                            items: _experience,
                          ),
                        ),
                        const SizedBox(width: 40),
                        Expanded(
                          child: _TimelineColumn(
                            label: '🎓  Education',
                            items: _education,
                          ),
                        ),
                      ],
                    )
                  else
                    Column(
                      children: [
                        _TimelineColumn(
                          label: '💼  Work Experience',
                          items: _experience,
                        ),
                        const SizedBox(height: 40),
                        _TimelineColumn(
                          label: '🎓  Education',
                          items: _education,
                        ),
                      ],
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

// ── Data model ────────────────────────────────────────────────────────────────

class _TimelineData {
  final String title;
  final String org;
  final String period;
  final String description;
  final IconData icon;
  final bool isCurrent;
  const _TimelineData({
    required this.title,
    required this.org,
    required this.period,
    required this.description,
    required this.icon,
    required this.isCurrent,
  });
}

// ── Column of timeline cards ──────────────────────────────────────────────────

class _TimelineColumn extends StatelessWidget {
  final String label;
  final List<_TimelineData> items;
  const _TimelineColumn({required this.label, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.accent,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 20),
        ...items.asMap().entries.map((e) => FadeSlideIn(
              delay: Duration(milliseconds: 150 * e.key),
              child: _TimelineCard(data: e.value, isLast: e.key == items.length - 1),
            )),
      ],
    );
  }
}

// ── Individual timeline card ──────────────────────────────────────────────────

class _TimelineCard extends StatefulWidget {
  final _TimelineData data;
  final bool isLast;
  const _TimelineCard({required this.data, required this.isLast});

  @override
  State<_TimelineCard> createState() => _TimelineCardState();
}

class _TimelineCardState extends State<_TimelineCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Timeline spine ──
          SizedBox(
            width: 40,
            child: Column(
              children: [
                // Dot
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: widget.data.isCurrent
                        ? AppColors.accent
                        : AppColors.accent.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.accent,
                      width: widget.data.isCurrent ? 0 : 1.5,
                    ),
                    boxShadow: widget.data.isCurrent
                        ? [
                            BoxShadow(
                              color: AppColors.accent.withValues(alpha: 0.4),
                              blurRadius: 12,
                              spreadRadius: 2,
                            )
                          ]
                        : [],
                  ),
                  child: Icon(
                    widget.data.icon,
                    size: 18,
                    color: widget.data.isCurrent
                        ? Colors.black
                        : AppColors.accent,
                  ),
                ),
                // Vertical line
                if (!widget.isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.accent.withValues(alpha: 0.4),
                            AppColors.accent.withValues(alpha: 0.05),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // ── Card content ──
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: widget.isLast ? 0 : 24),
              child: MouseRegion(
                onEnter: (_) => setState(() => _hovered = true),
                onExit: (_) => setState(() => _hovered = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: _hovered
                        ? AppColors.accent.withValues(alpha: 0.07)
                        : AppColors.cardBg,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: _hovered
                          ? AppColors.accent.withValues(alpha: 0.4)
                          : AppColors.divider,
                    ),
                    boxShadow: _hovered
                        ? [
                            BoxShadow(
                              color: AppColors.accent.withValues(alpha: 0.1),
                              blurRadius: 20,
                            )
                          ]
                        : [],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.data.isCurrent)
                        Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.accent.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.accent.withValues(alpha: 0.4),
                            ),
                          ),
                          child: Text(
                            '● Current',
                            style: TextStyle(
                              color: AppColors.accent,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      Text(
                        widget.data.title,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.data.org,
                        style: TextStyle(
                          color: AppColors.accent,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.data.period,
                        style: TextStyle(
                          color: AppColors.grey.withValues(alpha: 0.5),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.data.description,
                        style: TextStyle(
                          color: AppColors.grey.withValues(alpha: 0.75),
                          fontSize: 13,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
