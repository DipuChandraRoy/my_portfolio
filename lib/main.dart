import 'package:flutter/material.dart';
import 'constants/app_colors.dart';
import 'widgets/top_nav_bar.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
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

  // GlobalKeys for each section to enable smooth scroll navigation
  final _homeKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _servicesKey = GlobalKey();
  final _contactKey = GlobalKey();

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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // ── Sticky Nav Bar ──
          TopNavBar(onNavTap: _scrollToSection),

          // ── Scrollable Sections ──
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  // Home / Hero
                  Container(key: _homeKey, child: const HeroSection()),

                  // About
                  Container(key: _aboutKey, child: const AboutSection()),

                  // Projects
                  Container(key: _projectsKey, child: const ProjectsSection()),

                  // Services
                  Container(key: _servicesKey, child: const ServicesSection()),

                  // Contact
                  Container(key: _contactKey, child: const ContactSection()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
