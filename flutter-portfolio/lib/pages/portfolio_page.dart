import 'package:flutter/material.dart';

import '../content/portfolio_content.dart';
import '../content/all_projects.dart';
import '../widgets/project_gallery.dart';
import '../widgets/hero_showcase.dart';
import 'project_archive.dart';
import '../design/theme.dart';
import '../widgets/brand_widgets.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({
    super.key,
    required this.arabic,
    required this.onLanguageChange,
    required this.openLink,
    this.initialProject,
  });
  final bool arabic;
  final VoidCallback onLanguageChange;
  final Future<bool> Function(Uri) openLink;
  final String? initialProject;
  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final workKey = GlobalKey();
  final experienceKey = GlobalKey();
  final aboutKey = GlobalKey();
  final contactKey = GlobalKey();
  String t(Bilingual copy) => copy.inLanguage(widget.arabic);

  @override
  void initState() {
    super.initState();
    final matching = allProjects.where((p) => p.id == widget.initialProject);
    if (matching.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) showProject(matching.first);
      });
    }
  }

  void jump(GlobalKey key) {
    final target = key.currentContext;
    if (target != null) {
      Scrollable.ensureVisible(
        target,
        duration: MediaQuery.disableAnimationsOf(context)
            ? Duration.zero
            : const Duration(milliseconds: 400),
        alignment: 0.05,
      );
    }
  }

  Future<void> open(String url) async {
    final opened = await widget.openLink(Uri.parse(url));
    if (!opened && mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(t(Copy.linkFailed))));
    }
  }

  void showProject(Project project) => showDialog<void>(
    context: context,
    builder: (context) => Dialog(
      insetPadding: const EdgeInsets.all(20),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(24, 16, 12, 12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      project.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  IconButton(
                    tooltip: t(Copy.close),
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Flexible(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (project.images.isNotEmpty) ...[
                        ProjectGallery(project: project, arabic: widget.arabic),
                        const SizedBox(height: 28),
                      ],
                      Eyebrow(project.category.inLanguage(widget.arabic)),
                      const SizedBox(height: 16),
                      Text(
                        t(Copy.product),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 10),
                      Text(project.description.inLanguage(widget.arabic)),
                      const SizedBox(height: 24),
                      Text(
                        t(Copy.contribution),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 10),
                      Text(project.contribution.inLanguage(widget.arabic)),
                      const SizedBox(height: 24),
                      Text(
                        t(Copy.features),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 10),
                      ...project.features.map(
                        (f) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.check_circle_outline,
                                size: 19,
                                color: Brand.accent,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(f.inLanguage(widget.arabic)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(t(Copy.projectNote)),
                      const SizedBox(height: 24),
                      if (project.url.isNotEmpty)
                        FilledButton.icon(
                          onPressed: () => open(project.url),
                          icon: const Icon(Icons.open_in_new, size: 18),
                          label: Text(
                            t(project.code ? Copy.source : Copy.store),
                          ),
                        ),
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

  Widget languageToggle({bool compact = false}) => OutlinedButton(
    key: const ValueKey('language-toggle'),
    style: compact
        ? OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 12),
          )
        : null,
    onPressed: widget.onLanguageChange,
    child: Text(widget.arabic ? 'English' : 'العربية'),
  );

  Widget navigation(bool wide) => Padding(
    padding: EdgeInsets.symmetric(
      vertical: wide ? 20 : Brand.mobileHeaderSpace,
    ),
    child: wide
        ? Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 16,
            runSpacing: 12,
            children: [
              BrandIdentity(arabic: widget.arabic),
              TextButton(
                onPressed: () => jump(workKey),
                child: Text(t(Copy.work)),
              ),
              TextButton(
                onPressed: () => jump(experienceKey),
                child: Text(t(Copy.experience)),
              ),
              TextButton(
                onPressed: () => jump(aboutKey),
                child: Text(t(Copy.about)),
              ),
              const SizedBox(width: 16),
              languageToggle(),
              const SizedBox(width: 12),
              FilledButton(
                onPressed: () => jump(contactKey),
                child: Text(t(Copy.contact)),
              ),
            ],
          )
        : Row(
            children: [
              Expanded(child: BrandIdentity(arabic: widget.arabic)),
              const SizedBox(width: 8),
              languageToggle(compact: true),
              PopupMenuButton<int>(
                tooltip: t(Copy.menu),
                icon: const Icon(Icons.menu),
                onSelected: (value) =>
                    jump([workKey, experienceKey, aboutKey, contactKey][value]),
                itemBuilder: (_) =>
                    [Copy.work, Copy.experience, Copy.about, Copy.contact]
                        .asMap()
                        .entries
                        .map(
                          (e) => PopupMenuItem(
                            value: e.key,
                            child: Text(t(e.value)),
                          ),
                        )
                        .toList(),
              ),
            ],
          ),
  );

  Widget hero(bool wide) {
    final intro = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: Brand.line),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            child: Text(
              t(Copy.role),
              style: Theme.of(context).textTheme.labelLarge!
                  .copyWith(color: Brand.accent),
            ),
          ),
        ),
        SizedBox(height: wide ? 30 : Brand.mobileIntroGap),
        Text(
          t(Copy.hero),
          style: wide
              ? Theme.of(context).textTheme.displayLarge
              : Theme.of(context).textTheme.displaySmall,
        ),
        SizedBox(height: wide ? 24 : 16),
        Text(t(Copy.intro), style: Theme.of(context).textTheme.bodyLarge),
        SizedBox(height: wide ? 30 : Brand.space),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            TextButton.icon(
              onPressed: () => showDialog<void>(
                context: context,
                builder: (_) => ProjectArchive(
                  arabic: widget.arabic,
                  onProject: showProject,
                ),
              ),
              icon: const Icon(Icons.apps),
              label: Text(t(Copy.browseAll)),
            ),
            FilledButton.icon(
              onPressed: () => jump(workKey),
              icon: const Icon(Icons.arrow_downward, size: 18),
              label: Text(t(Copy.viewWork)),
            ),
            OutlinedButton.icon(
              onPressed: () => open(Uri.base.resolve('cv.pdf').toString()),
              icon: const Icon(Icons.description_outlined, size: 18),
              label: Text(t(Copy.cv)),
            ),
          ],
        ),
      ],
    );
    final artwork = HeroShowcase(
      arabic: widget.arabic,
      wide: wide,
      onProject: showProject,
    );
    return wide
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 6, child: Entrance(child: intro)),
              const SizedBox(width: 54),
              Expanded(flex: 5, child: artwork),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Entrance(child: intro),
              const SizedBox(height: Brand.space),
              artwork,
            ],
          );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SelectionArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ContentWidth(
              child: LayoutBuilder(
                builder: (_, c) => navigation(c.maxWidth >= Brand.desktop),
              ),
            ),
            const Divider(height: 1),
            ContentWidth(
              vertical: 72,
              mobileVertical: Brand.mobileSectionSpace,
              child: LayoutBuilder(
                builder: (_, c) => hero(c.maxWidth >= Brand.desktop),
              ),
            ),
            ColoredBox(
              color: Brand.mist,
              child: ContentWidth(
                vertical: 18,
                child: Wrap(
                  spacing: 28,
                  runSpacing: 12,
                  alignment: WrapAlignment.spaceBetween,
                  children:
                      const [
                            'Flutter & Dart',
                            'Clean Architecture',
                            'BLoC / Provider',
                            'REST APIs & Firebase',
                          ]
                          .map(
                            (s) => Text(
                              s,
                              style: const TextStyle(
                                color: Brand.ink,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
            ),
            ContentWidth(
              key: workKey,
              vertical: 72,
              mobileVertical: Brand.mobileSectionSpace,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeading(
                    index: '01 / ${t(Copy.work)}',
                    title: t(Copy.work),
                    description: t(Copy.selectedIntro),
                  ),
                  const SizedBox(height: 36),
                  LayoutBuilder(
                    builder: (_, c) => Wrap(
                      spacing: Brand.space,
                      runSpacing: Brand.space,
                      children: projects
                          .asMap()
                          .entries
                          .map(
                            (e) => SizedBox(
                              width: c.maxWidth >= 700
                                  ? (c.maxWidth - Brand.space) / 2
                                  : c.maxWidth,
                              child: ProjectCard(
                                project: e.value,
                                arabic: widget.arabic,
                                onTap: () => showProject(e.value),
                                index: e.key + 1,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            ContentWidth(
              vertical: 12,
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: FilledButton.icon(
                  onPressed: () => showDialog<void>(
                    context: context,
                    builder: (_) => ProjectArchive(
                      arabic: widget.arabic,
                      onProject: showProject,
                    ),
                  ),
                  icon: const Icon(Icons.apps),
                  label: Text(t(Copy.browseAll)),
                ),
              ),
            ),
            ContentWidth(
              key: experienceKey,
              vertical: 64,
              mobileVertical: Brand.mobileSectionSpace,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeading(
                    index: '02 / ${t(Copy.experience)}',
                    title: t(Copy.experience),
                  ),
                  const SizedBox(height: 30),
                  ...experiences.map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 22),
                      child: LayoutBuilder(
                        builder: (_, c) {
                          final details = Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.role.inLanguage(widget.arabic),
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 8),
                              Text(e.summary.inLanguage(widget.arabic)),
                            ],
                          );
                          final company = Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.company,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 8),
                              Eyebrow(e.period.inLanguage(widget.arabic)),
                            ],
                          );
                          return Column(
                            children: [
                              c.maxWidth >= 700
                                  ? Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(width: 290, child: company),
                                        Expanded(child: details),
                                      ],
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        company,
                                        const SizedBox(height: 16),
                                        details,
                                      ],
                                    ),
                              const SizedBox(height: 24),
                              const Divider(height: 1),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ColoredBox(
              color: Brand.mist,
              child: ContentWidth(
                key: aboutKey,
                vertical: 64,
                mobileVertical: Brand.mobileSectionSpace,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionHeading(
                      index: '03 / ${t(Copy.about)}',
                      title: t(Copy.approach),
                    ),
                    const SizedBox(height: 24),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: Text(
                        t(Copy.approachBody),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      t(Copy.education),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ),
            ColoredBox(
              color: Brand.ink,
              child: ContentWidth(
                key: contactKey,
                vertical: 64,
                mobileVertical: Brand.mobileSectionSpace,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Eyebrow('04 / ${t(Copy.contact)}', light: true),
                    const SizedBox(height: 24),
                    Text(
                      t(Copy.contactTitle),
                      style: Theme.of(context).textTheme.displaySmall!
                          .copyWith(color: Brand.white),
                    ),
                    const SizedBox(height: 20),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 680),
                      child: Text(
                        t(Copy.contactBody),
                        style: Theme.of(context).textTheme.bodyLarge!
                            .copyWith(color: Brand.line),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Wrap(
                      spacing: 14,
                      runSpacing: 14,
                      children: [
                        FilledButton.icon(
                          style: FilledButton.styleFrom(
                            backgroundColor: Brand.lime,
                            foregroundColor: Brand.ink,
                          ),
                          onPressed: () => open(
                            'https://www.linkedin.com/in/abdelrahman-amr-729400204/',
                          ),
                          icon: const Icon(Icons.north_east, size: 18),
                          label: Text(t(Copy.linkedin)),
                        ),
                        TextButton(
                          onPressed: () => open('https://github.com/abdo6400'),
                          child: Text(
                            t(Copy.github),
                            style: const TextStyle(color: Brand.white),
                          ),
                        ),
                        TextButton(
                          onPressed: () =>
                              open('https://www.facebook.com/abdo.amr.1048'),
                          child: Text(
                            t(Copy.facebook),
                            style: const TextStyle(color: Brand.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ContentWidth(
              vertical: 24,
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: 24,
                runSpacing: 12,
                children: [
                  Text(
                    t(Copy.name),
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Text(t(Copy.footer)),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
