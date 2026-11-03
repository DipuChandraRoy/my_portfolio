import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../widgets/section_title.dart';
import '../widgets/fade_slide_in.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Skills Section — Categorized skills & animated progress bars
// ─────────────────────────────────────────────────────────────────────────────

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  static const _categories = [
    _SkillCategory(
      title: 'Mobile Development',
      skills: ['Flutter', 'Dart', 'Material Design', 'Clean Architecture', 'Android & iOS'],
      icon: Icons.phone_android_rounded,
    ),
    _SkillCategory(
      title: 'State Management',
      skills: ['Riverpod', 'Provider', 'GetX'],
      icon: Icons.account_tree_rounded,
    ),
    _SkillCategory(
      title: 'API & Real-Time',
      skills: ['REST APIs', 'Dio', 'WebSocket', 'LiveKit', 'JSON'],
      icon: Icons.wifi_tethering_rounded,
    ),
    _SkillCategory(
      title: 'Backend & Database',
      skills: ['Firebase', 'SQLite', 'SharedPreferences'],
      icon: Icons.cloud_sync_rounded,
    ),
    _SkillCategory(
      title: 'UI/UX & Tools',
      skills: ['Figma', 'Postman', 'Git', 'GitHub', 'VS Code', 'Android Studio'],
      icon: Icons.design_services_rounded,
    ),
    _SkillCategory(
      title: 'Languages',
      skills: ['Bangla', 'English'],
      icon: Icons.translate_rounded,
    ),
  ];

  static const _skills = [
    _SkillData('Flutter & Dart', 0.92, Icons.phone_android_rounded),
    _SkillData('State Management (Riverpod / Provider / GetX)', 0.88, Icons.account_tree_rounded),
    _SkillData('API & Networking (REST APIs / Dio)', 0.88, Icons.api_rounded),
    _SkillData('Real-Time Features (LiveKit / WebSocket)', 0.82, Icons.stream_rounded),
    _SkillData('Backend & Storage (Firebase / SQLite)', 0.85, Icons.storage_rounded),
    _SkillData('UI/UX Design & Figma Implementation', 0.84, Icons.design_services_rounded),
    _SkillData('TensorFlow Lite (AI/ML)', 0.75, Icons.psychology_rounded),
    _SkillData('Git & GitHub Version Control', 0.86, Icons.code_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: screenWidth < 500 ? 50 : 80),
      color: const Color(0xFF0A0A0A),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 800;
          final double hPad = isWide ? 60 : (constraints.maxWidth < 500 ? 16 : 24);
          final double cardWidth = isWide
              ? (constraints.maxWidth - (hPad * 2) - 20) / 2
              : double.infinity;

          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              padding: EdgeInsets.symmetric(horizontal: hPad),
              child: Column(
                children: [
                  const FadeSlideIn(
                    child: SectionTitle(
                      title: 'My Skills',
                      subtitle: 'Technologies & expertise from my resume',
                    ),
                  ),
                  const SizedBox(height: 50),

                  // ── Resume Skill Categories ──
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: _categories.asMap().entries.map((entry) {
                      return FadeSlideIn(
                        delay: Duration(milliseconds: 80 * entry.key),
                        child: SizedBox(
                          width: cardWidth,
                          child: _CategoryCard(category: entry.value),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 40),

                  // ── Animated Skill Progress Bars ──
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isWide ? 2 : 1,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 20,
                      mainAxisExtent: 96,
                    ),
                    itemCount: _skills.length,
                    itemBuilder: (context, i) => FadeSlideIn(
                      delay: Duration(milliseconds: 70 * i),
                      child: _SkillBar(data: _skills[i]),
                    ),
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

// ── Category Data & Card ─────────────────────────────────────────────────────

class _SkillCategory {
  final String title;
  final List<String> skills;
  final IconData icon;
  const _SkillCategory({
    required this.title,
    required this.skills,
    required this.icon,
  });
}

class _CategoryCard extends StatelessWidget {
  final _SkillCategory category;
  const _CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(category.icon, color: AppColors.accent, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                category.title,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: category.skills.map((s) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.accent.withValues(alpha: 0.25),
                  ),
                ),
                child: Text(
                  s,
                  style: TextStyle(
                    color: AppColors.accent.withValues(alpha: 0.95),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// ── Skill Data & Animated Bar ─────────────────────────────────────────────────

class _SkillData {
  final String name;
  final double percent; // 0.0 – 1.0
  final IconData icon;
  const _SkillData(this.name, this.percent, this.icon);
}

class _SkillBar extends StatefulWidget {
  final _SkillData data;
  const _SkillBar({required this.data});

  @override
  State<_SkillBar> createState() => _SkillBarState();
}

class _SkillBarState extends State<_SkillBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _anim = Tween<double>(begin: 0, end: widget.data.percent).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic),
    );
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(widget.data.icon,
                    color: AppColors.accent, size: 16),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  widget.data.name,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              AnimatedBuilder(
                animation: _anim,
                builder: (_, __) => Text(
                  '${(_anim.value * 100).toInt()}%',
                  style: TextStyle(
                    color: AppColors.accent,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          AnimatedBuilder(
            animation: _anim,
            builder: (_, __) => ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: _anim.value,
                minHeight: 7,
                backgroundColor: AppColors.divider,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
