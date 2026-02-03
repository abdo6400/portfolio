import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/models/experience.dart';
import 'package:portfolio/models/skill.dart';
import 'package:portfolio/services/portfolio_service.dart';
import 'package:portfolio/theme.dart';
import 'package:portfolio/widgets/animated_reveal.dart';

class SkillsPage extends StatefulWidget {
  const SkillsPage({super.key});

  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  final _service = PortfolioService();
  Map<String, dynamic>? _profile;
  List<Skill> _skills = [];
  List<Experience> _experiences = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final profile = await _service.getProfile();
      final skills = await _service.getSkills();
      final experiences = await _service.getExperiences();
      setState(() {
        _profile = profile;
        _skills = skills;
        _experiences = experiences;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Failed to load data: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark
        ? AppColors.darkPrimaryText
        : AppColors.lightPrimaryText;
    final secondaryText = isDark
        ? AppColors.darkSecondaryText
        : AppColors.lightSecondaryText;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final divider = isDark ? AppColors.darkDivider : AppColors.lightDivider;
    final primary = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final success = isDark ? AppColors.darkSuccess : AppColors.lightSuccess;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SKILLS &',
                        style: Theme.of(context).textTheme.headlineLarge
                            ?.copyWith(
                              fontWeight: FontWeight.w900,
                              color: primaryText,
                              height: 1,
                            ),
                      ),
                      Text(
                        'EXPERIENCE',
                        style: Theme.of(context).textTheme.headlineLarge
                            ?.copyWith(
                              fontWeight: FontWeight.w900,
                              color: primary,
                              height: 1,
                            ),
                      ),
                    ],
                  ),
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(color: primary, width: 2),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      _profile?['imageDesc'] ?? '',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(color: surface),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              _SectionHeader(
                title: 'TECH_STACK',
                subtitle: 'Systems and languages I master',
              ),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _skills
                    .asMap()
                    .entries
                    .map(
                      (e) => Reveal.staggered(
                        index: e.key,
                        child: _SkillTag(skill: e.value),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: AppSpacing.xl),
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: surface,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: divider),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'EXPERTISE_DISTRIBUTION',
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 10,
                        color: secondaryText,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    SizedBox(
                      height: 180,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _BarChartItem(
                            label: 'Mobile',
                            value: 0.95,
                            color: primary,
                          ),
                          _BarChartItem(
                            label: 'Web',
                            value: 0.85,
                            color: primary,
                          ),
                          _BarChartItem(
                            label: 'Cloud',
                            value: 0.70,
                            color: primary,
                          ),
                          _BarChartItem(
                            label: 'UI/UX',
                            value: 0.90,
                            color: primary,
                          ),
                          _BarChartItem(
                            label: 'DevOps',
                            value: 0.65,
                            color: primary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              _SectionHeader(
                title: 'WORK_HISTORY',
                subtitle: 'My professional journey',
              ),
              ..._experiences.asMap().entries.map((entry) {
                final index = entry.key;
                final exp = entry.value;
                return Reveal.staggered(
                  index: index,
                  child: _ExperienceItem(
                    experience: exp,
                    showLine: index < _experiences.length - 1,
                  ),
                );
              }),
              const SizedBox(height: AppSpacing.xl),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: surface,
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        border: Border.all(color: divider),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '42+',
                            style: GoogleFonts.jetBrainsMono(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primary,
                            ),
                          ),
                          Text(
                            'Projects Done',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(color: secondaryText),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: surface,
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        border: Border.all(color: divider),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '5k+',
                            style: GoogleFonts.jetBrainsMono(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: success,
                            ),
                          ),
                          Text(
                            'Commits',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(color: secondaryText),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              SizedBox(
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download),
                  label: const Text('DOWNLOAD CV'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SectionHeader({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark
        ? AppColors.darkPrimaryText
        : AppColors.lightPrimaryText;
    final hint = isDark ? AppColors.darkHint : AppColors.lightHint;
    final primary = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 24,
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: GoogleFonts.jetBrainsMono(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: primaryText,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: hint),
        ),
        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }
}

class _SkillTag extends StatelessWidget {
  final Skill skill;

  const _SkillTag({required this.skill});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final divider = isDark ? AppColors.darkDivider : AppColors.lightDivider;
    final primaryText = isDark
        ? AppColors.darkPrimaryText
        : AppColors.lightPrimaryText;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: surface,
        border: Border.all(color: divider),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(skill.icon, color: skill.color, size: 16),
          const SizedBox(width: 8),
          Text(
            skill.name,
            style: GoogleFonts.jetBrainsMono(fontSize: 14, color: primaryText),
          ),
        ],
      ),
    );
  }
}

class _ExperienceItem extends StatelessWidget {
  final Experience experience;
  final bool showLine;

  const _ExperienceItem({required this.experience, required this.showLine});

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
              decoration: BoxDecoration(
                color: experience.dotColor,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
            ),
            if (showLine) Container(width: 2, height: 80, color: divider),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                experience.period,
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 10,
                  color: secondaryText,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                experience.role,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: primaryText,
                ),
              ),
              Text(
                experience.company,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: experience.dotColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                experience.description,
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

class _BarChartItem extends StatelessWidget {
  final String label;
  final double value;
  final Color color;

  const _BarChartItem({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final secondaryText = isDark
        ? AppColors.darkSecondaryText
        : AppColors.lightSecondaryText;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: value),
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeOutCubic,
          builder: (context, v, child) {
            return Container(
              width: 30,
              height: v * 150,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.labelSmall?.copyWith(color: secondaryText),
        ),
      ],
    );
  }
}
