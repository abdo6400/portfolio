import 'dart:async';

import 'package:flutter/material.dart';

import '../content/portfolio_content.dart';
import '../content/project_covers.dart';
import '../design/theme.dart';
import 'brand_widgets.dart';

class BrandIdentity extends StatelessWidget {
  const BrandIdentity({super.key, required this.arabic});
  final bool arabic;
  @override
  Widget build(BuildContext context) => SizedBox(
    width: 200,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: Brand.mist,
          backgroundImage: const AssetImage('assets/covers/profile.webp'),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Copy.firstName.inLanguage(arabic),
                style: Theme.of(context).textTheme.titleMedium!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              Text(
                Copy.lastName.inLanguage(arabic),
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class Entrance extends StatelessWidget {
  const Entrance({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
    tween: Tween(
      begin: MediaQuery.disableAnimationsOf(context) ? 1 : 0,
      end: 1,
    ),
    duration: const Duration(milliseconds: 400),
    curve: Curves.easeOut,
    child: child,
    builder: (_, value, child) => Opacity(
      opacity: value,
      child: Transform.translate(
        offset: Offset(0, 12 * (1 - value)),
        child: child,
      ),
    ),
  );
}

class HeroShowcase extends StatefulWidget {
  const HeroShowcase({
    super.key,
    required this.arabic,
    required this.wide,
    required this.onProject,
  });
  final bool arabic;
  final bool wide;
  final ValueChanged<Project> onProject;
  @override
  State<HeroShowcase> createState() => _HeroShowcaseState();
}

class _HeroShowcaseState extends State<HeroShowcase>
    with WidgetsBindingObserver {
  Timer? timer;
  int index = 0;
  bool paused = false;
  bool hovered = false;
  bool focused = false;
  bool foreground = true;
  bool reducedMotion = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    reducedMotion = MediaQuery.disableAnimationsOf(context);
    timer?.cancel();
    if (!reducedMotion) {
      timer = Timer.periodic(const Duration(seconds: 5), (_) {
        if (mounted && !paused && !hovered && !focused && foreground) {
          setState(() => index = (index + 1) % projects.length);
        }
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    foreground = state == AppLifecycleState.resumed;
  }

  @override
  void dispose() {
    timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final project = projects[index];
    return RepaintBoundary(
      child: MouseRegion(
        onEnter: (_) => hovered = true,
        onExit: (_) => hovered = false,
        child: Focus(
          onFocusChange: (value) => focused = value,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Palette.of(context).panel,
              border: Border.all(color: Palette.of(context).border),
              boxShadow: [
                BoxShadow(
                  color: Palette.of(context).accent.withValues(alpha: .08),
                  blurRadius: 42,
                ),
              ],
              borderRadius: BorderRadius.circular(Brand.radius),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Eyebrow(
                        Copy.work.inLanguage(widget.arabic),
                        light: false,
                      ),
                    ),
                    if (!reducedMotion)
                      IconButton(
                        color: Brand.lime,
                        tooltip: (paused ? Copy.resume : Copy.pauseSlides)
                            .inLanguage(widget.arabic),
                        onPressed: () => setState(() => paused = !paused),
                        icon: Icon(paused ? Icons.play_arrow : Icons.pause),
                      ),
                  ],
                ),
                const SizedBox(height: 18),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: reducedMotion ? 0 : 250),
                    child: InkWell(
                      key: ValueKey(project.id),
                      onTap: () => widget.onProject(project),
                      child: ProjectImage(
                        asset:
                            projectCovers[project.id] ?? project.images.first,
                        label: project.name,
                        arabic: widget.arabic,
                        height: widget.wide ? 240 : 190,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  project.name,
                  key: const ValueKey('showcase-project-name'),
                  style: Theme.of(context).textTheme.titleLarge!
                      .copyWith(color: Palette.of(context).text),
                ),
                const SizedBox(height: 6),
                Text(
                  project.category.inLanguage(widget.arabic),
                  style: Theme.of(context).textTheme.bodyMedium!
                      .copyWith(color: Palette.of(context).muted),
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 8,
                  children: projects
                      .asMap()
                      .entries
                      .map(
                        (e) => Semantics(
                          selected: index == e.key,
                          child: IconButton(
                            tooltip: e.value.name,
                            onPressed: () => setState(() => index = e.key),
                            icon: Icon(
                              index == e.key
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_unchecked,
                              size: 17,
                              color: index == e.key
                                  ? Palette.of(context).violet
                                  : Palette.of(context).muted,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
