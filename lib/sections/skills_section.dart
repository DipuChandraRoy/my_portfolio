import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../widgets/section_title.dart';
import '../widgets/fade_slide_in.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Skills Section — animated progress bars
// ─────────────────────────────────────────────────────────────────────────────

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  static const _skills = [
    _SkillData('Flutter & Dart', 0.92, Icons.phone_android_rounded),
    _SkillData('Firebase', 0.85, Icons.local_fire_department_rounded),
    _SkillData('REST API Integration', 0.88, Icons.api_rounded),
    _SkillData('UI/UX Design', 0.80, Icons.design_services_rounded),
    _SkillData('TensorFlow Lite (AI/ML)', 0.72, Icons.psychology_rounded),
    _SkillData('State Management (Riverpod / Provider)', 0.87, Icons.account_tree_rounded),
    _SkillData('Git & GitHub', 0.83, Icons.code_rounded),
    _SkillData('Android & iOS Deployment', 0.78, Icons.rocket_launch_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80),
      color: const Color(0xFF0A0A0A),
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
                      title: 'My Skills',
                      subtitle: 'Technologies I work with',
                    ),
                  ),
                  const SizedBox(height: 50),
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
                      delay: Duration(milliseconds: 100 * i),
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

// ── Data model ────────────────────────────────────────────────────────────────

class _SkillData {
  final String name;
  final double percent; // 0.0 – 1.0
  final IconData icon;
  const _SkillData(this.name, this.percent, this.icon);
}

// ── Animated skill bar ────────────────────────────────────────────────────────

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
