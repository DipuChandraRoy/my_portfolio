import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart' show rootBundle;
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import '../constants/app_colors.dart';
import '../utils/resume_downloader.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Hero Section – Responsive Row / Column via LayoutBuilder
// ─────────────────────────────────────────────────────────────────────────────

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 800;
        final textSide = _HeroTextContent(isWide: isWide);
        final imageSide = _HeroProfileImage(isWide: isWide);
        if (isWide) {
          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 80),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(flex: 3, child: textSide),
                  const SizedBox(width: 60),
                  Expanded(flex: 2, child: imageSide),
                ],
              ),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              children: [imageSide, const SizedBox(height: 40), textSide],
            ),
          );
        }
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Left Side: Text Content & Action Buttons
// ─────────────────────────────────────────────────────────────────────────────

class _HeroTextContent extends StatelessWidget {
  final bool isWide;
  const _HeroTextContent({required this.isWide});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isWide
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── Greeting chip ──
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.accent.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.accent.withValues(alpha: 0.25)),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('👋', style: TextStyle(fontSize: 16)),
              SizedBox(width: 8),
              Text(
                'Hi, I am',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // ── Name ──
        Text(
          'Dipu Chandra Ray',
          textAlign: isWide ? TextAlign.left : TextAlign.center,
          style: TextStyle(
            color: AppColors.accent,
            fontSize: isWide ? 46 : 36,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 10),

        // ── Designation ──
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: isWide
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: [
            Container(
              width: 28,
              height: 3,
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                'Flutter Developer (Android & iOS) @ DeepVers Lab',
                style: TextStyle(
                  color: AppColors.accent.withValues(alpha: 0.85),
                  fontSize: isWide ? 20 : 15,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.6,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // ── Description ──
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Text(
            'Flutter Developer (Android & iOS) at DeepVers Lab — a software company. '
            'B.Sc. in CSE | Expert in Flutter, RESTful APIs, Firebase & TensorFlow Lite. '
            'Building seamless cross-platform mobile experiences.',
            textAlign: isWide ? TextAlign.left : TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.grey,
              fontSize: 15,
              height: 1.7,
              letterSpacing: 0.3,
            ),
          ),
        ),
        const SizedBox(height: 36),

        // ── Action Buttons ──
        Wrap(
          spacing: 16,
          runSpacing: 12,
          alignment: isWide ? WrapAlignment.start : WrapAlignment.center,
          children: [_HireMeButton(), _DownloadResumeButton()],
        ),
      ],
    );
  }
}

// ─── Hire Me Button ──────────────────────────────────────────────────────────

class _HireMeButton extends StatefulWidget {
  @override
  State<_HireMeButton> createState() => _HireMeButtonState();
}

class _HireMeButtonState extends State<_HireMeButton> {
  bool _hovered = false;

  Future<void> _openWhatsApp() async {
    // wa.me deep link — works on web, Android, iOS & macOS WhatsApp
    const phone = '8801753827779'; // country code without +
    const message = 'Hello Dipu! I visited your portfolio and would like to hire you.';
    final uri = Uri.parse(
      'https://wa.me/$phone?text=${Uri.encodeComponent(message)}',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: _hovered
            ? (Matrix4.identity()..translate(0.0, -2.0))
            : Matrix4.identity(),
        child: ElevatedButton(
          onPressed: _openWhatsApp,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accent,
            foregroundColor: Colors.black,
            elevation: _hovered ? 12 : 4,
            shadowColor: AppColors.accent.withValues(alpha: 0.5),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.rocket_launch_rounded, size: 18),
              SizedBox(width: 10),
              Text(
                'Hire Me',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Download Resume Button ──────────────────────────────────────────────────

class _DownloadResumeButton extends StatefulWidget {
  @override
  State<_DownloadResumeButton> createState() => _DownloadResumeButtonState();
}

class _DownloadResumeButtonState extends State<_DownloadResumeButton> {
  bool _hovered = false;
  bool _loading = false;

  Future<void> _downloadResume() async {
    setState(() => _loading = true);
    try {
      const assetPath = 'assets/files/dipu_resume.pdf';
      const fileName = 'Dipu_Chandra_Ray_Resume.pdf';

      if (kIsWeb) {
        // Flutter Web: triggers a real browser file download
        triggerWebDownload(assetPath, fileName);
      } else {
        // Desktop / Mobile:
        // 1. Read PDF bytes from the Flutter asset bundle
        // 2. Write to system temp directory
        // 3. Open with system PDF viewer via url_launcher
        final byteData = await rootBundle.load(assetPath);
        final tempDir = Directory.systemTemp;
        final tempFile = File('${tempDir.path}/$fileName');
        await tempFile.writeAsBytes(byteData.buffer.asUint8List(), flush: true);
        final uri = Uri.file(tempFile.path);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      }
    } catch (e) {
      debugPrint('Resume download error: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: _hovered
            ? (Matrix4.identity()..translate(0.0, -2.0))
            : Matrix4.identity(),
        child: OutlinedButton(
          onPressed: _loading ? null : _downloadResume,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.accent,
            side: BorderSide(
              color: _hovered
                  ? AppColors.accent
                  : AppColors.accent.withValues(alpha: 0.6),
              width: 1.5,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _loading
                  ? SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.accent,
                      ),
                    )
                  : Icon(
                      Icons.download_rounded,
                      size: 18,
                      color: _hovered
                          ? AppColors.accent
                          : AppColors.accent.withValues(alpha: 0.8),
                    ),
              const SizedBox(width: 10),
              const Text(
                'Download Resume',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Right Side: Profile Image with Neon Glow
// ─────────────────────────────────────────────────────────────────────────────

class _HeroProfileImage extends StatefulWidget {
  final bool isWide;
  const _HeroProfileImage({required this.isWide});

  @override
  State<_HeroProfileImage> createState() => _HeroProfileImageState();
}

class _HeroProfileImageState extends State<_HeroProfileImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(
      begin: 60,
      end: 100,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double imageSize = widget.isWide ? 280 : 220;

    return Center(
      child: AnimatedBuilder(
        animation: _glowAnimation,
        builder: (context, child) {
          return Container(
            width: imageSize + 40,
            height: imageSize + 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: 0.4),
                  blurRadius: _glowAnimation.value,
                  spreadRadius: 10,
                ),
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: 0.15),
                  blurRadius: 30,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: child,
          );
        },
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.accent,
                AppColors.accent.withValues(alpha: 0.3),
                AppColors.accent,
              ],
            ),
          ),
          child: CircleAvatar(
            radius: imageSize / 2,
            backgroundColor: AppColors.background,
            backgroundImage: const AssetImage('assets/images/profile.jpg'),
          ),
        ),
      ),
    );
  }
}
