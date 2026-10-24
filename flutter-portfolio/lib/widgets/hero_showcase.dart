import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/semantics.dart';

import '../content/portfolio_content.dart';
import '../content/featured_projects.dart';
import '../content/project_covers.dart';
import '../content/studio_content.dart';
import '../design/theme.dart';

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
  bool dragging = false;
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
        if (mounted &&
            !paused &&
            !hovered &&
            !focused &&
            !dragging &&
            foreground) {
          setState(() => index = (index + 1) % featuredProjects.length);
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

  double dragDistance = 0;
  void shift(int direction) => setState(() {
    index = (index + direction) % featuredProjects.length;
  });

  @override
  Widget build(BuildContext context) {
    final project = featuredProjects[index];
    final p = Palette.of(context);
    return RepaintBoundary(
      child: MouseRegion(
        onEnter: (_) => hovered = true,
        onExit: (_) => hovered = false,
        child: Focus(
          onFocusChange: (value) => focused = value,
          onKeyEvent: (_, event) {
            if (event is! KeyDownEvent) return KeyEventResult.ignored;
            final key = event.logicalKey;
            if (key != LogicalKeyboardKey.arrowLeft &&
                key != LogicalKeyboardKey.arrowRight) {
              return KeyEventResult.ignored;
            }
            final right = key == LogicalKeyboardKey.arrowRight;
            shift((right != widget.arabic) ? 1 : -1);
            return KeyEventResult.handled;
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Semantics(
                hint: StudioCopy.showcaseHint.inLanguage(widget.arabic),
                customSemanticsActions: {
                  CustomSemanticsAction(
                    label: StudioCopy.nextProject.inLanguage(widget.arabic),
                  ): () =>
                      shift(1),
                  CustomSemanticsAction(
                    label: StudioCopy.previousProject.inLanguage(widget.arabic),
                  ): () =>
                      shift(-1),
                },
                child: GestureDetector(
                  dragStartBehavior: DragStartBehavior.down,
                  onHorizontalDragStart: (_) {
                    dragging = true;
                    dragDistance = 0;
                  },
                  onHorizontalDragCancel: () {
                    dragging = false;
                    dragDistance = 0;
                  },
                  onHorizontalDragUpdate: (details) =>
                      dragDistance += details.delta.dx,
                  onHorizontalDragEnd: (_) {
                    if (dragDistance.abs() > 32) {
                      shift((dragDistance < 0) != widget.arabic ? 1 : -1);
                    }
                    dragDistance = 0;
                    dragging = false;
                  },
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(Brand.radius),
                        child: AspectRatio(
                          key: const ValueKey('showcase-image'),
                          aspectRatio: Brand.showcaseImageRatio,
                          child: AnimatedSwitcher(
                            duration: Duration(
                              milliseconds: reducedMotion ? 0 : 250,
                            ),
                            child: Material(
                              key: ValueKey(project.id),
                              color: p.raised,
                              child: InkWell(
                                onTap: () => widget.onProject(project),
                                child: Image.asset(
                                  projectCovers[project.id] ??
                                      project.images.first,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                  semanticLabel: project.name,
                                  errorBuilder: (_, _, _) => Center(
                                    child: Text(
                                      Copy.imageFailed.inLanguage(
                                        widget.arabic,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (!reducedMotion)
                        PositionedDirectional(
                          top: 8,
                          end: 8,
                          child: Material(
                            color: p.panel,
                            shape: const CircleBorder(),
                            child: IconButton(
                              color: p.text,
                              tooltip: (paused ? Copy.resume : Copy.pauseSlides)
                                  .inLanguage(widget.arabic),
                              onPressed: () => setState(() => paused = !paused),
                              iconSize: 18,
                              icon: Icon(
                                paused ? Icons.play_arrow : Icons.pause,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => widget.onProject(project),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            project.name,
                            key: const ValueKey('showcase-project-name'),
                            style: Theme.of(context).textTheme.titleLarge!
                                .copyWith(color: p.text),
                          ),
                        ),
                        Icon(Icons.arrow_outward, size: 22, color: p.accent),
                      ],
                    ),
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
