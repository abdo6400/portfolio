import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/models/project.dart';
import 'package:portfolio/services/portfolio_service.dart';
import 'package:portfolio/theme.dart';
import 'package:portfolio/widgets/animated_reveal.dart';
import 'package:portfolio/widgets/glass_container.dart';
import 'package:portfolio/widgets/interactive_3d_card.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  final _service = PortfolioService();
  Map<String, dynamic>? _profile;
  List<Project> _projects = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final profile = await _service.getProfile();
      final projects = await _service.getProjects();
      setState(() {
        _profile = profile;
        _projects = projects;
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
    final accent = isDark ? AppColors.darkAccent : AppColors.lightAccent;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: surface,
                  border: Border(bottom: BorderSide(color: divider)),
                ),
                child: Column(
                  children: [
                    Row(
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
                        const SizedBox(width: AppSpacing.lg),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _profile?['name'] ?? 'Alex Rivera',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(color: primaryText),
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                'Senior Product Designer & Flutter Developer',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: secondaryText),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_rounded,
                                    size: 14,
                                    color: accent,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    _profile?['location'] ??
                                        'San Francisco, CA',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(color: secondaryText),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => context.push('/cv'),
                            icon: Icon(
                              Icons.file_download_rounded,
                              color: primary,
                              size: 18,
                            ),
                            label: Text(
                              'Download CV',
                              style: TextStyle(color: primary),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => context.push('/contact'),
                            icon: Icon(Icons.mail_outline_rounded, size: 18),
                            label: const Text('Contact'),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Featured Projects',
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(color: primaryText),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'See All',
                            style: Theme.of(
                              context,
                            ).textTheme.labelLarge?.copyWith(color: accent),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    ..._projects.asMap().entries.map(
                      (e) => Reveal.staggered(
                        index: e.key,
                        child: _ProjectDetailCard(project: e.value),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: surface,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.xl,
                ),
                margin: const EdgeInsets.only(top: AppSpacing.lg),
                child: Column(
                  children: [
                    Text(
                      "Let's Connect",
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(color: primaryText),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _SocialIcon(icon: Icons.code_rounded, label: 'GitHub'),
                        _SocialIcon(
                          icon: Icons.public_rounded,
                          label: 'LinkedIn',
                        ),
                        _SocialIcon(
                          icon: Icons.camera_alt_rounded,
                          label: 'Dribbble',
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Divider(color: divider),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      '© 2024 Alex Rivera. Built with Dreamflow.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isDark
                            ? AppColors.darkHint
                            : AppColors.lightHint,
                      ),
                      textAlign: TextAlign.center,
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

class _ProjectDetailCard extends StatelessWidget {
  final Project project;

  const _ProjectDetailCard({required this.project});

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
    final background = isDark
        ? AppColors.darkBackground
        : AppColors.lightBackground;
    final primary = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;

    return GestureDetector(
      onTap: () => context.push('/project-details', extra: project),
      child: Interactive3DCard(
        child: GlassContainer(
          borderRadius: AppRadius.lg,
          padding: EdgeInsets.zero,
          opacity: 0.05,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 180,
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
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: primaryText,
                                ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                            vertical: AppSpacing.xs,
                          ),
                          decoration: BoxDecoration(
                            color: background,
                            borderRadius: BorderRadius.circular(AppSpacing.md),
                            border: Border.all(color: divider),
                          ),
                          child: Text(
                            project.category,
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(color: secondaryText),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      project.description,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: secondaryText),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Wrap(
                      spacing: AppSpacing.sm,
                      children: project.techStack.take(3).map((tech) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: background,
                            borderRadius: BorderRadius.circular(AppRadius.full),
                            border: Border.all(color: divider),
                          ),
                          child: Text(
                            tech,
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(color: primaryText),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 36,
                            child: ElevatedButton(
                              onPressed: () => context.push(
                                '/project-details',
                                extra: project,
                              ),
                              child: const Text(
                                'View Case Study',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppRadius.md),
                            border: Border.all(color: primary),
                          ),
                          child: Icon(
                            Icons.open_in_new_rounded,
                            color: primary,
                            size: 20,
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

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SocialIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final background = isDark
        ? AppColors.darkBackground
        : AppColors.lightBackground;
    final primary = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final secondaryText = isDark
        ? AppColors.darkSecondaryText
        : AppColors.lightSecondaryText;

    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(AppRadius.full),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, color: primary),
        ),
        const SizedBox(height: AppSpacing.sm),
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
