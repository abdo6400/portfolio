import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../content/all_projects.dart';
import '../content/portfolio_content.dart';
import '../content/studio_content.dart';
import '../design/theme.dart';
import '../widgets/brand_widgets.dart';
import '../widgets/featured_projects.dart';
import '../widgets/hero_showcase.dart';
import '../widgets/project_details.dart';
import '../widgets/section_reveal.dart';
import '../widgets/stacked_section.dart';

import 'portfolio_sections.dart';
import 'project_archive.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({
    super.key,
    required this.arabic,
    required this.onLanguageChange,
    required this.openLink,
    this.initialProject,
    this.dark = true,
    this.onThemeChange,
  });
  final bool arabic, dark;
  final VoidCallback onLanguageChange;
  final VoidCallback? onThemeChange;
  final Future<bool> Function(Uri) openLink;
  final String? initialProject;
  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final scroll = StackedScrollController();
  final header = GlobalKey();
  final anchors = List.generate(8, (_) => GlobalKey());
  final revealed = List.generate(8, (i) => ValueNotifier(i == 0));
  final active = ValueNotifier(0), progress = ValueNotifier(0.0);
  bool menuOpen = false, scheduled = false;
  static const navigation = [
    StudioCopy.home,
    Copy.about,
    StudioCopy.skills,
    StudioCopy.projects,
    Copy.experience,
    Copy.contact,
  ];
  static const destinations = [0, 1, 2, 3, 4, 6];
  String t(Bilingual text) => text.inLanguage(widget.arabic);
  @override
  void initState() {
    super.initState();
    scroll.addListener(scheduleMeasure);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      measure();
      final matches = allProjects.where((p) => p.id == widget.initialProject);
      if (mounted && matches.isNotEmpty) showProject(matches.first);
    });
  }

  void scheduleMeasure() {
    if (scheduled) return;
    scheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scheduled = false;
      if (mounted) measure();
    });
  }

  double get headerHeight {
    final box = header.currentContext?.findRenderObject();
    return box is RenderBox && box.hasSize ? box.size.height : 76;
  }

  void measure() {
    if (!mounted || !scroll.hasClients) return;
    final height = scroll.position.viewportDimension;
    var next = 0;
    for (var i = 0; i < 7; i++) {
      final panel = anchors[i].currentContext?.findRenderObject();
      if (panel is! RenderStackedSection || panel.geometry == null) continue;
      final start = panel.scrollStart;
      if (start < scroll.offset + height * .96 && !revealed[i].value) {
        revealed[i].value = true;
      }
      if (start <= scroll.offset + 48) next = i;
    }
    if (scroll.position.extentAfter < 8) next = 6;
    if (active.value != next) active.value = next;
    final ratio = scroll.position.maxScrollExtent <= 0
        ? 0.0
        : (scroll.offset / scroll.position.maxScrollExtent).clamp(0.0, 1.0);
    if ((progress.value - ratio).abs() > .002) progress.value = ratio;
  }

  void jump(int index) {
    if (menuOpen) setState(() => menuOpen = false);
    revealed[index].value = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !scroll.hasClients) return;
      final panel = anchors[index].currentContext?.findRenderObject();
      if (panel is! RenderStackedSection || panel.geometry == null) return;
      final target = panel.scrollStart.clamp(
        0.0,
        scroll.position.maxScrollExtent,
      );
      scroll.animateTo(
        target,
        duration: MediaQuery.disableAnimationsOf(context)
            ? Duration.zero
            : const Duration(milliseconds: 440),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  Future<bool> open(Uri uri) async {
    bool result;
    try {
      result = await widget.openLink(uri);
    } catch (_) {
      result = false;
    }
    if (!result && mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(t(Copy.linkFailed))));
    }
    return result;
  }

  void showProject(Project project) => showProjectDialog(
    context,
    project: project,
    arabic: widget.arabic,
    open: (url) async {
      await open(Uri.parse(url));
    },
  );
  void archive() => showDialog<void>(
    context: context,
    builder: (_) =>
        ProjectArchive(arabic: widget.arabic, onProject: showProject),
  );
  @override
  void dispose() {
    scroll.removeListener(scheduleMeasure);
    scroll.dispose();
    active.dispose();
    progress.dispose();
    for (final value in revealed) {
      value.dispose();
    }
    super.dispose();
  }

  Widget navLink(int index, int selected) => Semantics(
    selected: selected == destinations[index],
    child: TextButton(
      onPressed: () => jump(destinations[index]),
      style: TextButton.styleFrom(
        foregroundColor: selected == destinations[index]
            ? Palette.of(context).accent
            : Palette.of(context).muted,
      ),
      child: Text(
        t(navigation[index]),
        style: TextStyle(
          fontSize: 13,
          fontWeight: selected == destinations[index]
              ? FontWeight.w700
              : FontWeight.w500,
        ),
      ),
    ),
  );
  Widget navigationBar() => Container(
    key: header,
    decoration: BoxDecoration(
      color: Palette.of(context).background,
      border: Border(bottom: BorderSide(color: Palette.of(context).border)),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ContentWidth(
          child: LayoutBuilder(
            builder: (_, c) {
              final wide = c.maxWidth >= Brand.navDesktop;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: Brand.mobileHeaderSpace,
                    ),
                    child: Row(
                      children: [
                        if (wide)
                          BrandIdentity(arabic: widget.arabic)
                        else
                          Expanded(child: BrandIdentity(arabic: widget.arabic)),
                        if (wide)
                          Expanded(
                            child: ValueListenableBuilder<int>(
                              valueListenable: active,
                              builder: (_, value, _) => Wrap(
                                alignment: WrapAlignment.center,
                                children: List.generate(
                                  navigation.length,
                                  (i) => navLink(i, value),
                                ),
                              ),
                            ),
                          ),
                        IconButton(
                          key: const ValueKey('theme-toggle'),
                          tooltip: t(
                            widget.dark ? StudioCopy.light : StudioCopy.dark,
                          ),
                          onPressed: widget.onThemeChange,
                          icon: Icon(
                            widget.dark
                                ? Icons.light_mode_outlined
                                : Icons.dark_mode_outlined,
                            size: 20,
                          ),
                        ),
                        TextButton(
                          key: const ValueKey('language-toggle'),
                          onPressed: widget.onLanguageChange,
                          style: TextButton.styleFrom(
                            minimumSize: const Size(48, 44),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                          ),
                          child: Text(
                            widget.arabic ? 'EN' : (wide ? 'العربية' : 'AR'),
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                        if (wide) ...[
                          const SizedBox(width: 8),
                          FilledButton(
                            onPressed: () => jump(6),
                            child: Text(t(Copy.contact)),
                          ),
                        ] else
                          Semantics(
                            expanded: menuOpen,
                            child: IconButton(
                              key: const ValueKey('mobile-menu'),
                              tooltip: t(Copy.menu),
                              onPressed: () =>
                                  setState(() => menuOpen = !menuOpen),
                              icon: Icon(
                                menuOpen ? Icons.close : Icons.menu,
                                size: 22,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (!wide)
                    AnimatedSize(
                      duration: MediaQuery.disableAnimationsOf(context)
                          ? Duration.zero
                          : Brand.motion,
                      curve: Curves.easeOut,
                      alignment: Alignment.topCenter,
                      child: menuOpen
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: ValueListenableBuilder<int>(
                                valueListenable: active,
                                builder: (_, value, _) => Wrap(
                                  spacing: 10,
                                  runSpacing: 8,
                                  children: List.generate(
                                    navigation.length,
                                    (i) => navLink(i, value),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(width: double.infinity, height: 0),
                    ),
                ],
              );
            },
          ),
        ),
        ValueListenableBuilder<double>(
          valueListenable: progress,
          builder: (_, value, _) => LinearProgressIndicator(
            value: value,
            minHeight: 2,
            color: Palette.of(context).violet,
            backgroundColor: Colors.transparent,
            semanticsLabel: widget.arabic
                ? 'تقدم التصفح'
                : 'Page scroll progress',
          ),
        ),
      ],
    ),
  );
  Widget section(
    int i,
    Widget child, {
    required bool stacked,
    bool tinted = false,
  }) => StackedSectionSliver(
    key: anchors[i],
    enabled: stacked,
    // Contact still covers Services, then scrolls normally into the footer.
    pin: i < 6,
    child: RepaintBoundary(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: tinted
              ? Palette.of(context).panel
              : Palette.of(context).background,
          borderRadius: stacked && i > 0
              ? const BorderRadius.vertical(top: Radius.circular(Brand.radius))
              : null,
          border: stacked && i > 0
              ? Border.all(color: Palette.of(context).border)
              : Border(
                  top: BorderSide(
                    color: Palette.of(context).border.withValues(alpha: .55),
                  ),
                ),
        ),
        child: ContentWidth(
          vertical: Brand.sectionSpace,
          mobileVertical: i == 0 ? 28 : Brand.mobileSectionSpace,
          alignment: stacked ? const Alignment(0, -.2) : Alignment.topCenter,
          child: stacked
              ? child
              : SectionReveal(visible: revealed[i], stagger: i, child: child),
        ),
      ),
    ),
  );
  @override
  Widget build(BuildContext context) {
    final parts = PortfolioSections(
      arabic: widget.arabic,
      onProject: showProject,
      onWork: () => jump(3),
      onContact: () => jump(6),
      openLink: open,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) measure();
    });
    return Scaffold(
      body: Column(
        children: [
          Focus(
            includeSemantics: false,
            skipTraversal: true,
            onKeyEvent: (_, event) {
              if (menuOpen &&
                  event is KeyDownEvent &&
                  event.logicalKey == LogicalKeyboardKey.escape) {
                setState(() => menuOpen = false);
                return KeyEventResult.handled;
              }
              return KeyEventResult.ignored;
            },
            child: navigationBar(),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (_, viewport) {
                final stacked =
                    viewport.maxWidth >= Brand.stackMinWidth &&
                    viewport.maxHeight >= Brand.stackMinHeight &&
                    MediaQuery.textScalerOf(context).scale(1) <= 1.2 &&
                    !MediaQuery.disableAnimationsOf(context);
                return ScrollConfiguration(
                  behavior: const MaterialScrollBehavior().copyWith(
                    scrollbars: false,
                  ),
                  child: Scrollbar(
                    controller: scroll,
                    child: CustomScrollView(
                      key: const ValueKey('portfolio-scroll'),
                      controller: scroll,
                      paintOrder: SliverPaintOrder.lastIsTop,
                      slivers: [
                        section(0, parts.hero(context), stacked: stacked),
                        section(1, parts.about(context), stacked: stacked),
                        section(
                          2,
                          parts.skills(context),
                          stacked: stacked,
                          tinted: true,
                        ),
                        section(
                          3,
                          FeaturedProjects(
                            arabic: widget.arabic,
                            onProject: showProject,
                            onArchive: archive,
                          ),
                          stacked: stacked,
                        ),
                        section(4, parts.journey(context), stacked: stacked),
                        section(
                          5,
                          parts.services(context),
                          stacked: stacked,
                          tinted: true,
                        ),
                        section(6, parts.contact(context), stacked: stacked),
                        SliverToBoxAdapter(
                          key: anchors[7],
                          child: ColoredBox(
                            color: Palette.of(context).background,
                            child: ContentWidth(
                              vertical: 24,
                              child: Wrap(
                                spacing: 24,
                                runSpacing: 12,
                                alignment: WrapAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '© ${DateTime.now().year} ${t(Copy.name)}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall,
                                  ),
                                  Text(
                                    t(Copy.footer),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
