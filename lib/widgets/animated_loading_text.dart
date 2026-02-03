import 'package:flutter/material.dart';
import 'package:portfolio/theme.dart';

class AnimatedLoadingText extends StatelessWidget {
  const AnimatedLoadingText({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final accent = isDark ? AppColors.darkAccent : AppColors.lightAccent;
    final primaryText =
        isDark ? AppColors.darkPrimaryText : AppColors.lightPrimaryText;

    return SizedBox(
      width: 150,
      child: TweenAnimationBuilder(
        duration: const Duration(seconds: 3),
        tween: Tween(begin: 0.0, end: 1.0),
        builder: (context, value, child) => Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.full),
              child: LinearProgressIndicator(
                backgroundColor: primary.withOpacity(0.1),
                color: primary,
                value: value,
                minHeight: 6,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              '${(value * 100).toInt()}%',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryText,
                letterSpacing: 1.2,
                shadows: [
                  Shadow(
                    color: primary.withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(2, 2),
                  ),
                  Shadow(
                    color: accent.withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(-2, -2),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
