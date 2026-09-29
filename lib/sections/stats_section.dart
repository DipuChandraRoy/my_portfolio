import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Stats Section — animated counter cards
// ─────────────────────────────────────────────────────────────────────────────

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  static const _stats = [
    _StatData(value: 3, suffix: '+', label: 'Years Experience'),
    _StatData(value: 15, suffix: '+', label: 'Projects Completed'),
    _StatData(value: 5, suffix: '+', label: 'Technologies'),
    _StatData(value: 100, suffix: '%', label: 'Client Satisfaction'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accent.withValues(alpha: 0.08),
            AppColors.background,
            AppColors.accent.withValues(alpha: 0.05),
          ],
        ),
        border: Border.symmetric(
          horizontal: BorderSide(
            color: AppColors.accent.withValues(alpha: 0.15),
            width: 1,
          ),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 600;
          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              padding: EdgeInsets.symmetric(horizontal: isWide ? 60 : 24),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 24,
                runSpacing: 24,
                children: _stats
                    .map((s) => _AnimatedStatCard(data: s))
                    .toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ── Data model ────────────────────────────────────────────────────────────────

class _StatData {
  final int value;
  final String suffix;
  final String label;
  const _StatData({
    required this.value,
    required this.suffix,
    required this.label,
  });
}

// ── Animated stat card ────────────────────────────────────────────────────────

class _AnimatedStatCard extends StatefulWidget {
  final _StatData data;
  const _AnimatedStatCard({required this.data});

  @override
  State<_AnimatedStatCard> createState() => _AnimatedStatCardState();
}

class _AnimatedStatCardState extends State<_AnimatedStatCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _countAnim;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _countAnim = Tween<double>(begin: 0, end: widget.data.value.toDouble())
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));

    Future.delayed(const Duration(milliseconds: 300), () {
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
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 180,
        padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
        decoration: BoxDecoration(
          color: _hovered
              ? AppColors.accent.withValues(alpha: 0.12)
              : AppColors.cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered
                ? AppColors.accent.withValues(alpha: 0.5)
                : AppColors.divider,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.15),
                    blurRadius: 24,
                    spreadRadius: 2,
                  )
                ]
              : [],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBuilder(
              animation: _countAnim,
              builder: (_, __) {
                return RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: _countAnim.value.toInt().toString(),
                        style: TextStyle(
                          color: AppColors.accent,
                          fontSize: 42,
                          fontWeight: FontWeight.w800,
                          height: 1,
                        ),
                      ),
                      TextSpan(
                        text: widget.data.suffix,
                        style: TextStyle(
                          color: AppColors.accent,
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            Text(
              widget.data.label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.grey.withValues(alpha: 0.7),
                fontSize: 13,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
