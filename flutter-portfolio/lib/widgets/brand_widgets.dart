import 'package:flutter/material.dart';

import '../content/portfolio_content.dart';
import '../design/theme.dart';

class ContentWidth extends StatelessWidget {
  const ContentWidth({
    super.key,
    required this.child,
    this.vertical = 0,
    this.mobileVertical,
  });
  final Widget child;
  final double vertical;
  final double? mobileVertical;
  @override
  Widget build(BuildContext context) => Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: Brand.contentWidth + 48),
      child: LayoutBuilder(
        builder: (_, constraints) => Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Brand.space,
            vertical: constraints.maxWidth - Brand.space * 2 < Brand.desktop
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
      color: light ? Brand.lime : Brand.accent,
      letterSpacing: 1.3,
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
  final String asset;
  final String label;
  final bool arabic;
  final double height;
  @override
  Widget build(BuildContext context) => Semantics(
    label: label,
    image: true,
    child: Container(
      height: height,
      width: double.infinity,
      color: Brand.mist,
      child: asset.endsWith('.mp4')
          ? Center(
              child: Icon(
                Icons.play_circle_outline,
                size: 56,
                color: Brand.accent,
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

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    super.key,
    required this.project,
    required this.arabic,
    required this.onTap,
    required this.index,
    this.compact = false,
  });
  final Project project;
  final bool arabic;
  final VoidCallback onTap;
  final int index;
  final bool compact;
  @override
  Widget build(BuildContext context) => Material(
    color: Brand.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Brand.radius),
      side: const BorderSide(color: Brand.line),
    ),
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (project.images.isNotEmpty)
            ProjectImage(
              asset: project.images.first,
              label: project.name,
              arabic: arabic,
              height: compact ? 200 : 280,
            )
          else
            Container(
              height: compact ? 200 : 280,
              width: double.infinity,
              color: Brand.mist,
              child: Icon(
                project.tags.any((t) => t.contains('.NET'))
                    ? Icons.code
                    : Icons.devices,
                size: 64,
                color: Brand.accent,
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
                      child: Eyebrow(project.category.inLanguage(arabic)),
                    ),
                    Text(
                      index.toString().padLeft(2, '0'),
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  project.name,
                  maxLines: compact ? 2 : null,
                  overflow: compact ? TextOverflow.ellipsis : null,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  project.description.inLanguage(arabic),
                  maxLines: compact ? 3 : null,
                  overflow: compact ? TextOverflow.ellipsis : null,
                ),
                const SizedBox(height: 18),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: (compact ? project.tags.take(3) : project.tags)
                      .map(
                        (tag) => DecoratedBox(
                          decoration: BoxDecoration(
                            color: Brand.paper,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            child: Text(
                              tagTranslations[tag]?.inLanguage(arabic) ?? tag,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        Copy.readProject.inLanguage(arabic),
                        style: Theme.of(context).textTheme.labelLarge!
                            .copyWith(color: Brand.accent),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.arrow_forward,
                      size: 18,
                      color: Brand.accent,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.index,
    required this.title,
    this.description,
  });
  final String index;
  final String title;
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
        Text(description!, style: Theme.of(context).textTheme.bodyLarge),
      ],
    ],
  );
}
