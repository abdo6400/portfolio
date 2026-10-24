import 'package:flutter/material.dart';

import '../content/portfolio_content.dart';
import '../content/project_covers.dart';
import '../design/theme.dart';

class ContentWidth extends StatelessWidget {
  const ContentWidth({
    super.key,
    required this.child,
    this.vertical = 0,
    this.mobileVertical,
    this.alignment = Alignment.topCenter,
  });
  final Widget child;
  final double vertical;
  final double? mobileVertical;
  final AlignmentGeometry alignment;
  @override
  Widget build(BuildContext context) => Align(
    alignment: alignment,
    heightFactor: 1,
    child: ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: Brand.contentWidth + Brand.space * 2,
      ),
      child: LayoutBuilder(
        builder: (_, c) => Padding(
          padding: EdgeInsets.symmetric(
            horizontal: c.maxWidth < Brand.desktop
                ? Brand.mobileGutter
                : Brand.space,
            vertical: c.maxWidth - Brand.space * 2 < Brand.desktop
                ? mobileVertical ?? vertical
                : vertical,
          ),
          child: child,
        ),
      ),
    ),
  );
}

class Eyebrow extends StatelessWidget {
  const Eyebrow(this.text, {super.key, this.light = false});
  final String text;
  final bool light;
  @override
  Widget build(BuildContext context) => Text(
    text,
    style: Theme.of(context).textTheme.labelLarge!.copyWith(
      color: light ? Brand.lime : Palette.of(context).accent,
      letterSpacing: 1.2,
      height: 1.6,
    ),
  );
}

class ProjectImage extends StatelessWidget {
  const ProjectImage({
    super.key,
    required this.asset,
    required this.label,
    required this.arabic,
    this.height = 280,
  });
  final String asset, label;
  final bool arabic;
  final double height;
  @override
  Widget build(BuildContext context) => Semantics(
    label: label,
    image: true,
    child: Container(
      height: height,
      width: double.infinity,
      color: Palette.of(context).raised,
      child: asset.endsWith('.mp4')
          ? Center(
              child: Icon(
                Icons.play_circle_outline,
                size: 56,
                color: Palette.of(context).accent,
              ),
            )
          : Image.asset(
              asset,
              fit: BoxFit.contain,
              excludeFromSemantics: true,
              errorBuilder: (_, _, _) =>
                  Center(child: Text(Copy.imageFailed.inLanguage(arabic))),
            ),
    ),
  );
}

class ProjectCard extends StatefulWidget {
  const ProjectCard({
    super.key,
    required this.project,
    required this.arabic,
    required this.onTap,
    required this.index,
    this.compact = false,
  });
  final Project project;
  final bool arabic, compact;
  final VoidCallback onTap;
  final int index;
  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool engaged = false;
  void engage(bool value) {
    if (engaged != value) setState(() => engaged = value);
  }

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final project = widget.project;
    return Semantics(
      button: true,
      label:
          '${project.name}. ${project.description.inLanguage(widget.arabic)}. ${Copy.readProject.inLanguage(widget.arabic)}',
      excludeSemantics: true,
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) => engage(true),
        onExit: (_) => engage(false),
        child: AnimatedContainer(
          duration: MediaQuery.disableAnimationsOf(context)
              ? Duration.zero
              : Brand.motion,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Brand.radius),
            border: Border.all(color: engaged ? p.accent : p.border),
            color: p.panel,
            boxShadow: engaged
                ? [
                    BoxShadow(
                      color: p.accent.withValues(alpha: .10),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [],
          ),
          clipBehavior: Clip.antiAlias,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onTap,
              onFocusChange: engage,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (project.images.isNotEmpty)
                    ProjectImage(
                      asset: projectCovers[project.id] ?? project.images.first,
                      label: project.name,
                      arabic: widget.arabic,
                      height: widget.compact ? 190 : 260,
                    )
                  else
                    Container(
                      height: widget.compact ? 190 : 260,
                      width: double.infinity,
                      color: p.raised,
                      child: Icon(
                        project.tags.any((t) => t.contains('.NET'))
                            ? Icons.code
                            : Icons.devices,
                        size: 64,
                        color: p.accent,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(Brand.space),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Eyebrow(
                                project.category.inLanguage(widget.arabic),
                              ),
                            ),
                            Text(
                              widget.index.toString().padLeft(2, '0'),
                              style: TextStyle(color: p.muted, fontSize: 12),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          project.name,
                          maxLines: widget.compact ? 2 : null,
                          overflow: widget.compact
                              ? TextOverflow.ellipsis
                              : null,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          project.description.inLanguage(widget.arabic),
                          maxLines: widget.compact ? 3 : null,
                          overflow: widget.compact
                              ? TextOverflow.ellipsis
                              : null,
                        ),
                        const SizedBox(height: 18),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children:
                              (widget.compact
                                      ? project.tags.take(3)
                                      : project.tags)
                                  .map(
                                    (tag) => TechnologyChip(
                                      label:
                                          tagTranslations[tag]?.inLanguage(
                                            widget.arabic,
                                          ) ??
                                          tag,
                                    ),
                                  )
                                  .toList(),
                        ),
                        const SizedBox(height: 22),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                Copy.readProject.inLanguage(widget.arabic),
                                style: Theme.of(context).textTheme.labelLarge!
                                    .copyWith(color: p.accent),
                              ),
                            ),
                            Icon(
                              Icons.arrow_outward,
                              size: 20,
                              color: p.accent,
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
        ),
      ),
    );
  }
}

class TechnologyChip extends StatelessWidget {
  const TechnologyChip({super.key, required this.label});
  final String label;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
    decoration: BoxDecoration(
      color: Palette.of(context).raised,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(label, style: Theme.of(context).textTheme.labelMedium),
  );
}

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.index,
    required this.title,
    this.description,
  });
  final String index, title;
  final String? description;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Eyebrow(index),
      const SizedBox(height: 12),
      Text(title, style: Theme.of(context).textTheme.displaySmall),
      if (description != null) ...[
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 650),
          child: Text(
            description!,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    ],
  );
}

class GradientHeading extends StatelessWidget {
  const GradientHeading({
    super.key,
    required this.leading,
    required this.accent,
    required this.label,
    required this.style,
  });
  final String leading, accent, label;
  final TextStyle style;
  @override
  Widget build(BuildContext context) => Semantics(
    header: true,
    label: label,
    excludeSemantics: true,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(leading, style: style),
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => LinearGradient(
            colors: [Palette.of(context).accent, Palette.of(context).violet],
          ).createShader(bounds),
          child: Text(accent, style: style.copyWith(color: Colors.white)),
        ),
      ],
    ),
  );
}
