import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/pages/home_page.dart';
import 'package:portfolio/pages/projects_page.dart';
import 'package:portfolio/pages/project_details_page.dart';
import 'package:portfolio/pages/skills_page.dart';
import 'package:portfolio/pages/cv_page.dart';
import 'package:portfolio/pages/contact_page.dart';
import 'package:portfolio/models/project.dart';
import 'package:portfolio/theme.dart';
import 'package:portfolio/services/localization_service.dart';
import 'package:portfolio/widgets/glass_container.dart';
import 'package:portfolio/widgets/animated_background.dart';
import 'package:portfolio/widgets/floating_nav_bar.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            _AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                name: 'home',
                pageBuilder: (context, state) =>
                    _buildTransitionPage(const HomePage()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.projects,
                name: 'projects',
                pageBuilder: (context, state) =>
                    _buildTransitionPage(const ProjectsPage()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.skills,
                name: 'skills',
                pageBuilder: (context, state) =>
                    _buildTransitionPage(const SkillsPage()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.cv,
                name: 'cv',
                pageBuilder: (context, state) =>
                    _buildTransitionPage(const CvPage()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.contact,
                name: 'contact',
                pageBuilder: (context, state) =>
                    _buildTransitionPage(const ContactPage()),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.projectDetails,
        name: 'project-details',
        pageBuilder: (context, state) {
          final project = state.extra as Project;
          return _buildTransitionPage(ProjectDetailsPage(project: project));
        },
      ),
    ],
  );
}

class AppRoutes {
  static const String home = '/';
  static const String projects = '/projects';
  static const String projectDetails = '/project-details';
  static const String skills = '/skills';
  static const String cv = '/cv';
  static const String contact = '/contact';
}

CustomTransitionPage<T> _buildTransitionPage<T>(Widget child) =>
    CustomTransitionPage<T>(
      key: ValueKey(child.hashCode),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );
        final opacity = Tween<double>(begin: 0, end: 1).animate(curved);
        final offset = Tween<Offset>(
          begin: const Offset(0, 0.02),
          end: Offset.zero,
        ).animate(curved);
        return FadeTransition(
          opacity: opacity,
          child: SlideTransition(position: offset, child: child),
        );
      },
      transitionDuration: const Duration(milliseconds: 280),
      reverseTransitionDuration: const Duration(milliseconds: 220),
      child: child,
    );

class _AppShell extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const _AppShell({required this.navigationShell});

  @override
  State<_AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<_AppShell> {
  int get _currentIndex => widget.navigationShell.currentIndex;

  void _onDestinationSelected(int index) {
    final isSame = index == _currentIndex;
    widget.navigationShell.goBranch(index, initialLocation: isSame);
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final size = MediaQuery.of(context).size;
    final isLargeScreen = size.width > 700;

    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);

    if (isLargeScreen) {
      return Scaffold(
        body: AnimatedBackground(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GlassContainer(
                  borderRadius: 24,
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Column(
                    children: [
                      _buildToggles(
                        themeProvider,
                        localeProvider,
                        isLarge: true,
                      ),
                      const SizedBox(height: 32),
                      Expanded(
                        child: NavigationRail(
                          selectedIndex: _currentIndex,
                          onDestinationSelected: _onDestinationSelected,
                          labelType: NavigationRailLabelType.all,
                          backgroundColor: Colors.transparent,
                          indicatorColor: primaryColor.withOpacity(0.1),
                          destinations: [
                            NavigationRailDestination(
                              icon: const Icon(Icons.home_outlined),
                              selectedIcon: const Icon(Icons.home_rounded),
                              label: Text(context.tr('home')),
                            ),
                            NavigationRailDestination(
                              icon: const Icon(Icons.work_outline_rounded),
                              selectedIcon: const Icon(Icons.work_rounded),
                              label: Text(context.tr('nav_projects')),
                            ),
                            NavigationRailDestination(
                              icon: const Icon(Icons.bolt_outlined),
                              selectedIcon: const Icon(Icons.bolt_rounded),
                              label: Text(context.tr('skills')),
                            ),
                            NavigationRailDestination(
                              icon: const Icon(Icons.description_outlined),
                              selectedIcon: const Icon(
                                Icons.description_rounded,
                              ),
                              label: Text(context.tr('cv')),
                            ),
                            NavigationRailDestination(
                              icon: const Icon(Icons.mail_outline_rounded),
                              selectedIcon: const Icon(Icons.mail_rounded),
                              label: Text(context.tr('contact')),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(child: widget.navigationShell),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          AnimatedBackground(child: SafeArea(child: widget.navigationShell)),
          Positioned(
            top: 16 + MediaQuery.of(context).padding.top,
            right: 16,
            child: _buildToggles(themeProvider, localeProvider, isLarge: false),
          ),
        ],
      ),
      bottomNavigationBar: FloatingNavBar(
        currentIndex: _currentIndex,
        onTap: _onDestinationSelected,
        items: [
          FloatingNavItem(icon: Icons.home_rounded, label: context.tr('home')),
          FloatingNavItem(
            icon: Icons.work_rounded,
            label: context.tr('nav_projects'),
          ),
          FloatingNavItem(
            icon: Icons.bolt_rounded,
            label: context.tr('skills'),
          ),
          FloatingNavItem(
            icon: Icons.description_rounded,
            label: context.tr('cv'),
          ),
          FloatingNavItem(
            icon: Icons.mail_rounded,
            label: context.tr('contact'),
          ),
        ],
      ),
    );
  }

  Widget _buildToggles(
    ThemeProvider themeProvider,
    LocaleProvider localeProvider, {
    required bool isLarge,
  }) {
    final isDark = themeProvider.themeMode == ThemeMode.dark;

    return isLarge
        ? Column(
            children: [
              _ToggleButton(
                icon:
                    isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                onTap: themeProvider.toggleTheme,
              ),
              const SizedBox(height: 12),
              _ToggleButton(
                label: localeProvider.isAr ? 'EN' : 'AR',
                onTap: localeProvider.toggleLocale,
              ),
            ],
          )
        : GlassContainer(
            borderRadius: 30,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            opacity: 0.1,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _ToggleButton(
                  icon: isDark
                      ? Icons.light_mode_rounded
                      : Icons.dark_mode_rounded,
                  onTap: themeProvider.toggleTheme,
                ),
                const SizedBox(width: 8),
                _ToggleButton(
                  label: localeProvider.isAr ? 'EN' : 'AR',
                  onTap: localeProvider.toggleLocale,
                ),
              ],
            ),
          );
  }
}

class _ToggleButton extends StatelessWidget {
  final IconData? icon;
  final String? label;
  final VoidCallback onTap;

  const _ToggleButton({this.icon, this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withOpacity(0.05)
              : Colors.black.withOpacity(0.05),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: icon != null
            ? Icon(
                icon,
                size: 18,
                color: isDark ? Colors.white70 : Colors.black87,
              )
            : Text(
                label!,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
