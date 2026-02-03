import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/theme.dart';
import 'package:portfolio/widgets/animated_loading_text.dart';
import 'package:portfolio/widgets/animated_texts_componenets.dart';
import 'package:portfolio/widgets/animated_background.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    // Navigate after 3.5 seconds (slightly before the loading bar finishes)
    Timer(const Duration(milliseconds: 3500), () {
      if (mounted) {
        context.go('/');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText =
        isDark ? AppColors.darkPrimaryText : AppColors.lightPrimaryText;

    return Scaffold(
      body: AnimatedBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AnimatedImageContainer(
                width: 120,
                height: 120,
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(
                'INITIALIZING_PORTFOLIO...',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      letterSpacing: 4,
                      fontWeight: FontWeight.bold,
                      color: primaryText.withOpacity(0.6),
                    ),
              ),
              const SizedBox(height: AppSpacing.md),
              const AnimatedLoadingText(),
            ],
          ),
        ),
      ),
    );
  }
}
