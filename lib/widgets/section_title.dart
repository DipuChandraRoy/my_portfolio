import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const SectionTitle({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 600;
    final isSmall = screenWidth < 380;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isSmall) ...[
              Container(
                width: isMobile ? 24 : 40,
                height: 3,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(width: isMobile ? 10 : 16),
            ],
            Flexible(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: isMobile ? (isSmall ? 22 : 26) : 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: isMobile ? 0.6 : 1.0,
                ),
              ),
            ),
            if (!isSmall) ...[
              SizedBox(width: isMobile ? 10 : 16),
              Container(
                width: isMobile ? 24 : 40,
                height: 3,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 10),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.grey.withValues(alpha: 0.7),
            fontSize: isMobile ? 13 : 15,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}
