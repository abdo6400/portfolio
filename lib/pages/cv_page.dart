import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/models/experience.dart';
import 'package:portfolio/models/skill.dart';
import 'package:portfolio/services/portfolio_service.dart';
import 'package:portfolio/theme.dart';
import 'package:portfolio/widgets/animated_reveal.dart';

class CvPage extends StatefulWidget {
  const CvPage({super.key});

  @override
  State<CvPage> createState() => _CvPageState();
}

class _CvPageState extends State<CvPage> {
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
                  color: surface,
                  border: Border(bottom: BorderSide(color: divider)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_rounded, color: primaryText),
                      onPressed: () => context.pop(),
                    ),
                    Text(
                      'PROFESSIONAL CV',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.share_rounded, color: primaryText),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.xl,
                ),
                decoration: BoxDecoration(
                  color: surface,
                  border: Border(bottom: BorderSide(color: divider)),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: primary, width: 2),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.asset(
                          _profile?['imageDesc'] ?? '',
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              Container(color: surface),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      (_profile?['name'] ?? 'Abdulrahman Amr').toUpperCase(),
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: primaryText,
                          ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      _profile?['title'] ?? 'Software Engineer',
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 14,
                        color: secondaryText,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 36,
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.download_rounded, size: 18),
                            label: const Text(
                              'Download PDF',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        SizedBox(
                          height: 36,
                          child: OutlinedButton.icon(
                            onPressed: () => context.push('/contact'),
                            icon: Icon(
                              Icons.mail_outline_rounded,
                              size: 18,
                              color: primary,
                            ),
                            label: Text(
                              'Contact Me',
                              style: TextStyle(fontSize: 12, color: primary),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _SectionHeader(
                      title: 'EXECUTIVE SUMMARY',
                      icon: Icons.description_rounded,
                    ),
                    Text(
                      _profile?['bio'] ?? '',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: secondaryText,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    _SectionHeader(
                      title: 'WORK EXPERIENCE',
                      icon: Icons.work_history_rounded,
                    ),
                    ..._experiences.asMap().entries.map(
                      (e) => Reveal.staggered(
                        index: e.key,
                        child: _ExperienceCard(experience: e.value),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    _SectionHeader(
                      title: 'TECHNICAL STACK',
                      icon: Icons.terminal_rounded,
                    ),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: _skills
                          .asMap()
                          .entries
                          .map(
                            (e) => Reveal.staggered(
                              index: e.key,
                              child: _SkillChip(skill: e.value),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    _SectionHeader(
                      title: 'EDUCATION',
                      icon: Icons.school_rounded,
                    ),
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: surface,
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                        border: Border.all(color: divider),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bachelor of Computer Science',
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: primaryText,
                                ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            'Ain Shams University',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: primary,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Text(
                            'Graduated: Aug 2023',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: secondaryText),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Column(
                      children: [
                        Divider(color: divider),
                        const SizedBox(height: AppSpacing.md),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.public_rounded,
                              color: secondaryText,
                              size: 20,
                            ),
                            const SizedBox(width: AppSpacing.lg),
                            Icon(
                              Icons.code_rounded,
                              color: secondaryText,
                              size: 20,
                            ),
                            const SizedBox(width: AppSpacing.lg),
                            Icon(
                              Icons.business_center_rounded,
                              color: secondaryText,
                              size: 20,
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'Generated via ProtoFolio v1.0',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: isDark
                                    ? AppColors.darkHint
                                    : AppColors.lightHint,
                              ),
                        ),
                      ],
                    ),
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

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionHeader({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: primary, size: 18),
            const SizedBox(width: AppSpacing.sm),
            Text(
              title,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: primary,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Container(
          width: 40,
          height: 2,
          decoration: BoxDecoration(
            color: primary,
            borderRadius: BorderRadius.circular(1),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
      ],
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  final Experience experience;

  const _ExperienceCard({required this.experience});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final divider = isDark ? AppColors.darkDivider : AppColors.lightDivider;
    final primaryText = isDark
        ? AppColors.darkPrimaryText
        : AppColors.lightPrimaryText;
    final secondaryText = isDark
        ? AppColors.darkSecondaryText
        : AppColors.lightSecondaryText;
    final primary = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(color: divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  experience.role,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: primaryText,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                experience.period,
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(color: secondaryText),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            experience.company,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            experience.description,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: secondaryText, height: 1.5),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _SkillChip extends StatelessWidget {
  final Skill skill;

  const _SkillChip({required this.skill});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final background = isDark
        ? AppColors.darkBackground
        : AppColors.lightBackground;
    final divider = isDark ? AppColors.darkDivider : AppColors.lightDivider;
    final primaryText = isDark
        ? AppColors.darkPrimaryText
        : AppColors.lightPrimaryText;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      margin: const EdgeInsets.only(right: 4, bottom: 8),
      decoration: BoxDecoration(
        color: background,
        border: Border.all(color: divider),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Text(
        skill.name,
        style: GoogleFonts.jetBrainsMono(fontSize: 10, color: primaryText),
      ),
    );
  }
}
