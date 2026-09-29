import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../widgets/section_title.dart';

// ─────────────────────────────────────────────────────────────────────────────
// About Section
// ─────────────────────────────────────────────────────────────────────────────

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80),
      decoration: const BoxDecoration(
        color: Color(0xFF0D0D0D),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 800;

          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              padding: EdgeInsets.symmetric(
                horizontal: isWide ? 60 : (constraints.maxWidth < 500 ? 16 : 24),
              ),
              child: Column(
                children: [
                  const SectionTitle(
                    title: 'About Me',
                    subtitle: 'Get to know me better',
                  ),
                  const SizedBox(height: 50),
                  if (isWide)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _AboutImage(isWide: true)),
                        const SizedBox(width: 60),
                        Expanded(child: _AboutDetails()),
                      ],
                    )
                  else
                    Column(
                      children: [
                        _AboutImage(isWide: false),
                        const SizedBox(height: 40),
                        _AboutDetails(),
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

// ─── About Image Card ────────────────────────────────────────────────────────

class _AboutImage extends StatelessWidget {
  final bool isWide;
  const _AboutImage({this.isWide = true});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final double imgHeight = isWide
        ? 380
        : (screenWidth < 500 ? 250 : 330);

    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: imgHeight,
          maxWidth: isWide ? double.infinity : 400,
        ),
        height: imgHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.accent.withValues(alpha: 0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withValues(alpha: 0.08),
              blurRadius: 40,
              spreadRadius: 2,
            ),
          ],
          image: const DecorationImage(
            image: AssetImage('assets/images/profile.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

// ─── About Text Details ──────────────────────────────────────────────────────

class _AboutDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Bio ──
        const Text(
          'Creative UI/UX Designer & Flutter Developer',
          style: TextStyle(
            color: AppColors.accent,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'I am Dipu Chandra Ray, a Flutter Developer (Android & iOS) currently working at '
          'DeepVers Lab — a software company. I build intuitive, responsive cross-platform '
          'mobile applications using Flutter, integrate backend REST APIs and Firebase, '
          'and deploy on-device AI/ML models using TensorFlow Lite.',
          style: TextStyle(
            color: AppColors.grey.withValues(alpha: 0.8),
            fontSize: 15,
            height: 1.8,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'With a B.Sc. in Computer Science & Engineering, I combine strong user-centered '
          'design principles with clean Dart code architecture to deliver seamless, '
          'high-performance mobile experiences across Android and iOS platforms.',
          style: TextStyle(
            color: AppColors.grey.withValues(alpha: 0.8),
            fontSize: 15,
            height: 1.8,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 30),

        // ── Quick Info Grid ──
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: const [
          _InfoChip(icon: Icons.person_outline, label: 'Dipu Chandra Ray'),
            _InfoChip(icon: Icons.phone_outlined, label: '+880 1753-827779'),
            _InfoChip(icon: Icons.email_outlined, label: 'dipuray7779@gmail.com'),
            _InfoChip(icon: Icons.location_on_outlined, label: 'Uttara, Dhaka, Bangladesh'),
            _InfoChip(icon: Icons.work_outline, label: 'DeepVers Lab'),
            _InfoChip(icon: Icons.phone_android_rounded, label: 'Android & iOS Dev'),
          ],
        ),
      ],
    );
  }
}

// ─── Info Chip ───────────────────────────────────────────────────────────────

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.divider,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.accent, size: 18),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 13,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
