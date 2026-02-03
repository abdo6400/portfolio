import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/models/project.dart';
import 'package:portfolio/theme.dart';

class ProjectDetailsPage extends StatelessWidget {
  final Project project;

  const ProjectDetailsPage({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark
        ? AppColors.darkPrimaryText
        : AppColors.lightPrimaryText;
    final secondaryText = isDark
        ? AppColors.darkSecondaryText
        : AppColors.lightSecondaryText;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final divider = isDark ? AppColors.darkDivider : AppColors.lightDivider;
    final background = isDark
        ? AppColors.darkBackground
        : AppColors.lightBackground;
    final accent = isDark ? AppColors.darkAccent : AppColors.lightAccent;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.lg,
                ),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: divider)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 20,
                        color: primaryText,
                      ),
                      onPressed: () => context.pop(),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.terminal_rounded,
                          color: secondaryText,
                          size: 18,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          'PROJECT_DETAILS.MD',
                          style: GoogleFonts.jetBrainsMono(
                            fontSize: 14,
                            color: primaryText,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.share_rounded,
                        size: 20,
                        color: primaryText,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  SizedBox(
                    height: 240,
                    child: Hero(
                      tag: 'project-${project.id}',
                      child: Image.asset(
                        project.imageDesc,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (_, __, ___) => Container(color: surface),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, background],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            project.title,
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: primaryText,
                                ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFF22D3EE,
                            ).withValues(alpha: 0.13),
                            border: Border.all(color: const Color(0xFF22D3EE)),
                            borderRadius: BorderRadius.circular(AppRadius.md),
                          ),
                          child: Text(
                            'LIVE',
                            style: GoogleFonts.jetBrainsMono(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF22D3EE),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      project.description,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(color: secondaryText),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: project.techStack.map((tech) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: surface,
                            border: Border.all(color: divider),
                            borderRadius: BorderRadius.circular(AppRadius.md),
                          ),
                          child: Text(
                            tech,
                            style: GoogleFonts.jetBrainsMono(
                              fontSize: 10,
                              color: secondaryText,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Divider(color: divider),
                    const SizedBox(height: AppSpacing.lg),
                    Row(
                      children: [
                        Expanded(
                          child: _StatItem(
                            label: 'ROLE',
                            value: 'Lead Designer',
                          ),
                        ),
                        Expanded(
                          child: _StatItem(
                            label: 'DURATION',
                            value: '4 Months',
                          ),
                        ),
                        Expanded(
                          child: _StatItem(
                            label: 'PLATFORM',
                            value: 'iOS / Android',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      '01_THE_CHALLENGE',
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 12,
                        color: secondaryText,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      decoration: BoxDecoration(
                        color: surface,
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        border: Border.all(color: divider),
                      ),
                      child: Text(
                        "The primary hurdle was creating a solution that was both intuitive for users and scalable for enterprise needs. We needed to maintain optimal performance while handling complex data operations.",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: primaryText,
                          height: 1.6,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      '02_EXECUTION_PROCESS',
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 12,
                        color: secondaryText,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _ProcessStep(
                      title: 'Architecture Design',
                      description:
                          'Defining the component hierarchy and data flow.',
                      color: const Color(0xFFF472B6),
                      showLine: true,
                    ),
                    _ProcessStep(
                      title: 'UI Engine Core',
                      description: 'Building the responsive layout system.',
                      color: const Color(0xFF22D3EE),
                      showLine: true,
                    ),
                    _ProcessStep(
                      title: 'Beta Testing',
                      description:
                          'Internal stress tests with diverse use cases.',
                      color: const Color(0xFF4ADE80),
                      showLine: false,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      '03_SCREENSHOTS',
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 12,
                        color: secondaryText,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _ScreenshotCard(
                            imageDesc:
                                'assets/images/mobile_app_interface_dark_mode_null_1770051660278.jpg',
                          ),
                          _ScreenshotCard(
                            imageDesc:
                                'assets/images/mobile_app_settings_screen_null_1770051661222.jpg',
                          ),
                          _ScreenshotCard(
                            imageDesc:
                                'assets/images/mobile_app_analytics_chart_null_1770051662135.jpg',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.code_rounded, size: 18),
                            label: const Text('View Source Code'),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.open_in_new_rounded, size: 18),
                            label: const Text('Visit Live Site'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark
        ? AppColors.darkPrimaryText
        : AppColors.lightPrimaryText;
    final hint = isDark ? AppColors.darkHint : AppColors.lightHint;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.jetBrainsMono(fontSize: 10, color: hint),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: primaryText,
          ),
        ),
      ],
    );
  }
}

class _ProcessStep extends StatelessWidget {
  final String title;
  final String description;
  final Color color;
  final bool showLine;

  const _ProcessStep({
    required this.title,
    required this.description,
    required this.color,
    required this.showLine,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark
        ? AppColors.darkPrimaryText
        : AppColors.lightPrimaryText;
    final secondaryText = isDark
        ? AppColors.darkSecondaryText
        : AppColors.lightSecondaryText;
    final divider = isDark ? AppColors.darkDivider : AppColors.lightDivider;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 12,
              height: 12,
              margin: const EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(AppRadius.full),
              ),
            ),
            if (showLine) Container(width: 2, height: 40, color: divider),
          ],
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: primaryText,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                description,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: secondaryText),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (showLine) const SizedBox(height: AppSpacing.md),
            ],
          ),
        ),
      ],
    );
  }
}

class _ScreenshotCard extends StatelessWidget {
  final String imageDesc;

  const _ScreenshotCard({required this.imageDesc});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final divider = isDark ? AppColors.darkDivider : AppColors.lightDivider;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;

    return Container(
      width: 160,
      height: 280,
      margin: const EdgeInsets.only(right: AppSpacing.md),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.lg),
        border: Border.all(color: divider),
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        imageDesc,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(color: surface),
      ),
    );
  }
}
