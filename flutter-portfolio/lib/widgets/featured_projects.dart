import 'package:flutter/material.dart';

import '../content/portfolio_content.dart';
import '../content/studio_content.dart';
import '../design/theme.dart';
import 'brand_widgets.dart';

class FeaturedProjects extends StatefulWidget {
  const FeaturedProjects({
    super.key,
    required this.arabic,
    required this.onProject,
    required this.onArchive,
  });
  final bool arabic;
  final ValueChanged<Project> onProject;
  final VoidCallback onArchive;
  @override
  State<FeaturedProjects> createState() => _FeaturedProjectsState();
}

class _FeaturedProjectsState extends State<FeaturedProjects> {
  int category = 0;
  static const labels = [
    StudioCopy.all,
    Bilingual('Financial services', 'خدمات مالية'),
    Bilingual('Marketplaces', 'الأسواق الإلكترونية'),
    Bilingual('News & media', 'الأخبار والإعلام'),
  ];
  bool matches(Project p) => switch (category) {
    1 => p.id == 'sadad',
    2 => p.id == 'thamin' || p.id == 'pack-and-go',
    3 => p.id == 'addustour',
    _ => true,
  };
  @override
  Widget build(BuildContext context) {
    final visible = projects.where(matches).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(
          index: '03 / ${StudioCopy.projects.inLanguage(widget.arabic)}',
          title: StudioCopy.projectsTitle.inLanguage(widget.arabic),
          description: Copy.selectedIntro.inLanguage(widget.arabic),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(
            labels.length,
            (i) => ChoiceChip(
              label: Text(labels[i].inLanguage(widget.arabic)),
              selected: category == i,
              onSelected: (_) => setState(() => category = i),
            ),
          ),
        ),
        const SizedBox(height: 24),
        LayoutBuilder(
          builder: (_, c) {
            final columns = c.maxWidth >= 700 ? 2 : 1;
            return Wrap(
              spacing: Brand.space,
              runSpacing: Brand.space,
              children: visible
                  .map(
                    (p) => SizedBox(
                      width:
                          (c.maxWidth - (columns - 1) * Brand.space) / columns,
                      child: ProjectCard(
                        project: p,
                        arabic: widget.arabic,
                        index: projects.indexOf(p) + 1,
                        onTap: () => widget.onProject(p),
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        ),
        const SizedBox(height: 24),
        OutlinedButton.icon(
          onPressed: widget.onArchive,
          icon: const Icon(Icons.grid_view, size: 18),
          label: Text(Copy.browseAll.inLanguage(widget.arabic)),
        ),
      ],
    );
  }
}
