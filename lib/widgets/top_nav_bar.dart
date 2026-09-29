import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class TopNavBar extends StatelessWidget {
  final Function(String) onNavTap;

  const TopNavBar({super.key, required this.onNavTap});

  static const List<String> navItems = [
    'Home',
    'About',
    'Projects',
    'Services',
    'Contact',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
      decoration: const BoxDecoration(
        color: AppColors.navBarBg,
        border: Border(
          bottom: BorderSide(color: AppColors.divider, width: 1),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ── Logo / Brand ──
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'D',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Dipu Chandra Ray',
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),

              // ── Nav Links ──
              if (!isMobile)
                Row(
                  children: navItems.map((item) {
                    return _NavLink(
                      label: item,
                      onTap: () => onNavTap(item),
                    );
                  }).toList(),
                )
              else
                PopupMenuButton<String>(
                  icon: const Icon(Icons.menu, color: AppColors.white),
                  color: AppColors.cardBg,
                  onSelected: onNavTap,
                  itemBuilder: (context) => navItems
                      .map((item) => PopupMenuItem(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(color: AppColors.white),
                            ),
                          ))
                      .toList(),
                ),
            ],
          );
        },
      ),
    );
  }
}

// ─── Single Nav Link with Hover Animation ────────────────────────────────────

class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _NavLink({required this.label, required this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors.accent.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              color: _hovered ? AppColors.accent : AppColors.grey,
              fontSize: 14,
              fontWeight: _hovered ? FontWeight.w600 : FontWeight.w400,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }
}
