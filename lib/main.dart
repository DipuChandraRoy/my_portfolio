import 'package:flutter/material.dart';
import 'constants/app_colors.dart';
import 'widgets/top_nav_bar.dart';
import 'sections/hero_section.dart';
import 'sections/stats_section.dart';
import 'sections/about_section.dart';
import 'sections/skills_section.dart';
import 'sections/timeline_section.dart';
import 'sections/projects_section.dart';
import 'sections/services_section.dart';
import 'sections/contact_section.dart';

void main() {
  runApp(const MyApp());
}

// ─────────────────────────────────────────────────────────────────────────────
// App Root
// ─────────────────────────────────────────────────────────────────────────────

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dipu Chandra Ray | Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.dark(
          primary: AppColors.accent,
          surface: AppColors.background,
        ),
        fontFamily: 'Roboto',
      ),
      home: const PortfolioHome(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Portfolio Home – Smooth-scrolling single-page layout
// ─────────────────────────────────────────────────────────────────────────────

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollTop = false;

  // GlobalKeys for each section to enable smooth scroll navigation
  final _homeKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _servicesKey = GlobalKey();
  final _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final show = _scrollController.offset > 400;
      if (show != _showScrollTop) setState(() => _showScrollTop = show);
    });
  }

  void _scrollToSection(String section) {
    GlobalKey targetKey;
    switch (section) {
      case 'Home':
        targetKey = _homeKey;
        break;
      case 'About':
        targetKey = _aboutKey;
        break;
      case 'Projects':
        targetKey = _projectsKey;
        break;
      case 'Services':
        targetKey = _servicesKey;
        break;
      case 'Contact':
        targetKey = _contactKey;
        break;
      default:
        return;
    }

    final context = targetKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: MouseRegion(
        // Use system cursor on desktop for reliability
        cursor: SystemMouseCursors.basic,
        child: Stack(
          children: [
            // ── Main layout ──
            Column(
              children: [
                // Sticky Nav Bar
                TopNavBar(onNavTap: _scrollToSection),

                // Scrollable Sections
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        Container(key: _homeKey, child: const HeroSection()),
                        const RepaintBoundary(child: StatsSection()),
                        Container(key: _aboutKey, child: const AboutSection()),
                        const RepaintBoundary(child: SkillsSection()),
                        const TimelineSection(),
                        Container(key: _projectsKey, child: const ProjectsSection()),
                        Container(key: _servicesKey, child: const ServicesSection()),
                        Container(key: _contactKey, child: const ContactSection()),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // ── Scroll-to-Top FAB ──
            Positioned(
              bottom: MediaQuery.sizeOf(context).width < 500 ? 20 : 32,
              right: MediaQuery.sizeOf(context).width < 500 ? 20 : 32,
              child: AnimatedOpacity(
                opacity: _showScrollTop ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: AnimatedScale(
                  scale: _showScrollTop ? 1.0 : 0.5,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutBack,
                  child: _ScrollTopButton(onTap: _scrollToTop),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Scroll-to-Top FAB Button
// ─────────────────────────────────────────────────────────────────────────────

class _ScrollTopButton extends StatefulWidget {
  final VoidCallback onTap;
  const _ScrollTopButton({required this.onTap});

  @override
  State<_ScrollTopButton> createState() => _ScrollTopButtonState();
}

class _ScrollTopButtonState extends State<_ScrollTopButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: _hovered ? AppColors.accent : AppColors.cardBg,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.accent.withValues(alpha: _hovered ? 1 : 0.5),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.accent.withValues(alpha: _hovered ? 0.4 : 0.15),
                blurRadius: _hovered ? 20 : 8,
                spreadRadius: _hovered ? 2 : 0,
              ),
            ],
          ),
          child: Icon(
            Icons.keyboard_arrow_up_rounded,
            color: _hovered ? Colors.black : AppColors.accent,
            size: 26,
          ),
        ),
      ),
    );
  }
}
