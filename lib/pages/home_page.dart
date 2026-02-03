import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/services/portfolio_service.dart';
import 'package:portfolio/models/project.dart';
import 'package:portfolio/models/skill.dart';
import 'package:portfolio/models/social.dart';
import 'package:portfolio/models/experience.dart';
import 'package:portfolio/theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio/widgets/animated_reveal.dart';
import 'package:portfolio/widgets/widget_tree_visual.dart';
import 'package:portfolio/services/localization_service.dart';
import 'package:portfolio/widgets/glass_container.dart';
import 'package:portfolio/widgets/interactive_3d_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _service = PortfolioService();
  Map<String, dynamic>? _profile;
  List<Project> _projects = [];
  List<Skill> _skills = [];
  List<Social> _socials = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      await _service.initializeData();
      final profile = await _service.getProfile();
      final projects = await _service.getProjects();
      final skills = await _service.getSkills();
      final socials = await _service.getSocials();
      setState(() {
        _profile = profile;
        _projects = projects.take(2).toList();
        _skills = skills;
        _socials = socials;
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
    final primaryText =
        isDark ? AppColors.darkPrimaryText : AppColors.lightPrimaryText;
    final secondaryText =
        isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final divider = isDark ? AppColors.darkDivider : AppColors.lightDivider;
    final accent = isDark ? AppColors.darkAccent : AppColors.lightAccent;
    final success = isDark ? AppColors.darkSuccess : AppColors.lightSuccess;
    final primary = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.tr('app_title'),
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: primaryText,
                      ),
                    ),
                  ],
                ),
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isLarge = constraints.maxWidth > 900;
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isLarge ? 64 : 32,
                      vertical: 32,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Reveal(
                                delay: const Duration(milliseconds: 80),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 140,
                                      height: 140,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          AppRadius.md,
                                        ),
                                        border: Border.all(
                                          color: primary,
                                          width: 2,
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(6),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          AppRadius.sm,
                                        ),
                                        child: Image.asset(
                                          _profile?['imageDesc'] ?? '',
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) =>
                                              Container(color: surface),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: GlassContainer(
                                        borderRadius: 8,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 6,
                                        ),
                                        color: success,
                                        opacity: 0.8,
                                        child: Text(
                                          context.tr('available'),
                                          style: GoogleFonts.jetBrainsMono(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: AppSpacing.lg),
                              Interactive3DCard(
                                maxTiltAngle: 0.05,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _profile?['title'] ?? '',
                                      style: GoogleFonts.jetBrainsMono(
                                        fontSize: 12,
                                        color: secondaryText,
                                      ),
                                    ),
                                    const SizedBox(height: AppSpacing.sm),
                                    ShaderMask(
                                      shaderCallback: (bounds) =>
                                          LinearGradient(
                                        colors: [
                                          primaryText,
                                          primary.withOpacity(0.7),
                                        ],
                                      ).createShader(bounds),
                                      child: Text(
                                        _profile?['bio'] ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.w900,
                                              color: Colors.white,
                                              fontSize: isLarge ? 64 : 40,
                                              height: 1.1,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: AppSpacing.md),
                              Wrap(
                                spacing: AppSpacing.md,
                                runSpacing: AppSpacing.md,
                                children: [
                                  NavChip(
                                    icon: Icons.description_rounded,
                                    label: context.tr('download_cv'),
                                    onTap: () => context.push('/cv'),
                                  ),
                                  NavChip(
                                    icon: Icons.mail_outline_rounded,
                                    label: context.tr('contact_me'),
                                    onTap: () => context.push('/contact'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (isLarge)
                          const Expanded(
                            flex: 2,
                            child: Reveal(
                              delay: Duration(milliseconds: 200),
                              child: WidgetTreeVisual(),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
              if (MediaQuery.of(context).size.width <= 900)
                const Reveal(
                  delay: Duration(milliseconds: 200),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 48),
                    child: WidgetTreeVisual(),
                  ),
                ),
              const SizedBox(height: 64),
              Reveal(
                delay: const Duration(milliseconds: 100),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: GlassContainer(
                    padding: const EdgeInsets.symmetric(
                      vertical: 64,
                      horizontal: 24,
                    ),
                    borderRadius: 32,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Reveal.staggered(
                          index: 0,
                          child: _StatColumn(
                            value: _profile?['yearsExperience'] ?? '05+',
                            label: context.tr('years_exp'),
                            color: primary,
                          ),
                        ),
                        Container(width: 1, height: 40, color: divider),
                        Reveal.staggered(
                          index: 1,
                          child: _StatColumn(
                            value: _profile?['projectsCount'] ?? '42',
                            label: context.tr('projects'),
                            color: accent,
                          ),
                        ),
                        Container(width: 1, height: 40, color: divider),
                        Reveal.staggered(
                          index: 2,
                          child: _StatColumn(
                            value: _profile?['awardsCount'] ?? '12',
                            label: context.tr('awards'),
                            color: success,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr('technical_stack'),
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 12,
                        color: secondaryText,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Wrap(
                      spacing: AppSpacing.md,
                      runSpacing: AppSpacing.md,
                      children: _skills
                          .asMap()
                          .entries
                          .map(
                            (e) => Reveal.staggered(
                              index: e.key,
                              child: SkillPill(skill: e.value),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          context.tr('selected_works'),
                          style: GoogleFonts.jetBrainsMono(
                            fontSize: 12,
                            color: secondaryText,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.push('/projects'),
                          child: Text(
                            context.tr('view_all'),
                            style: GoogleFonts.jetBrainsMono(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    ..._projects.asMap().entries.map(
                          (e) => Reveal.staggered(
                            index: e.key,
                            child: ProjectCard(project: e.value),
                          ),
                        ),
                  ],
                ),
              ),
              const SizedBox(height: 80),
              Reveal(
                delay: const Duration(milliseconds: 120),
                child: Container(
                  color: surface,
                  padding: const EdgeInsets.all(48),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.tr('lets_connect'),
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryText,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        context.tr('collab_text'),
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge?.copyWith(color: secondaryText),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      Row(
                        children: _socials.map((social) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              right: AppSpacing.md,
                            ),
                            child: SocialButton(
                              icon: social.icon,
                              onTap: () => launchUrl(Uri.parse(social.url)),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      GestureDetector(
                        onTap: () => context.push('/contact'),
                        child: Container(
                          width: double.infinity,
                          constraints: const BoxConstraints(maxWidth: 400),
                          height: 64,
                          decoration: BoxDecoration(
                            color: primaryText,
                            borderRadius: BorderRadius.circular(AppRadius.md),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            context.tr('say_hello'),
                            style: GoogleFonts.jetBrainsMono(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: isDark ? Colors.black : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(48),
                alignment: Alignment.center,
                child: Text(
                  context.tr('footer_text'),
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 10,
                    color: isDark ? AppColors.darkHint : AppColors.lightHint,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const NavChip({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final divider = isDark ? AppColors.darkDivider : AppColors.lightDivider;
    final primaryText =
        isDark ? AppColors.darkPrimaryText : AppColors.lightPrimaryText;
    final secondaryText =
        isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: divider),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: secondaryText),
            const SizedBox(width: 10),
            Text(
              label,
              style: GoogleFonts.jetBrainsMono(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: primaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const _StatColumn({
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final secondaryText =
        isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText;

    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.jetBrainsMono(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: secondaryText,
                letterSpacing: 1.2,
                fontSize: 10,
              ),
        ),
      ],
    );
  }
}

class SkillPill extends StatelessWidget {
  final Skill skill;

  const SkillPill({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final divider = isDark ? AppColors.darkDivider : AppColors.lightDivider;
    final primaryText =
        isDark ? AppColors.darkPrimaryText : AppColors.lightPrimaryText;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: divider),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: skill.color,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            skill.name,
            style: GoogleFonts.jetBrainsMono(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: primaryText,
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final divider = isDark ? AppColors.darkDivider : AppColors.lightDivider;
    final primaryText =
        isDark ? AppColors.darkPrimaryText : AppColors.lightPrimaryText;
    final secondaryText =
        isDark ? AppColors.darkSecondaryText : AppColors.lightSecondaryText;
    final background =
        isDark ? AppColors.darkBackground : AppColors.lightBackground;

    return GestureDetector(
      onTap: () => context.push('/project-details', extra: project),
      child: Interactive3DCard(
        child: GlassContainer(
          borderRadius: AppRadius.md,
          padding: EdgeInsets.zero,
          opacity: 0.05,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 240,
                child: Hero(
                  tag: 'project-${project.id}',
                  child: Image.asset(
                    project.imageDesc,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(color: surface),
                  ),
                ),
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
                            style: GoogleFonts.jetBrainsMono(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryText,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_outward_rounded,
                          size: 20,
                          color: secondaryText,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      project.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: secondaryText,
                            height: 1.5,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      children: project.techStack.map((tech) {
                        return Padding(
                          padding: const EdgeInsets.only(right: AppSpacing.sm),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: background,
                              borderRadius: BorderRadius.circular(AppRadius.sm),
                              border: Border.all(color: divider),
                            ),
                            child: Text(
                              tech,
                              style: GoogleFonts.jetBrainsMono(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: secondaryText,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
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

class SocialButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const SocialButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final divider = isDark ? AppColors.darkDivider : AppColors.lightDivider;
    final primaryText =
        isDark ? AppColors.darkPrimaryText : AppColors.lightPrimaryText;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: divider),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: primaryText, size: 24),
      ),
    );
  }
}
