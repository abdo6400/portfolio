import 'package:flutter/material.dart';
import 'package:portfolio/controllers/views_controller.dart';

import 'package:portfolio/views/information/components/title_text.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'components/information_grid.dart';
import 'components/skills_section.dart';

class InformationSectionView extends StatelessWidget {
  final String title;
  final int index;
  final Color? color;
  final String? contentType; // 'projects', 'certificates', 'skills'
  const InformationSectionView({
    super.key,
    required this.title,
    required this.index,
    this.color,
    this.contentType,
  });

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('section_$index'),
      onVisibilityChanged: (visibilityInfo) {
        // Update visibility tracking for this section
        final visibility = visibilityInfo.visibleFraction;
        if (context.mounted) {
          context.read<ViewsController>().updateSectionVisibility(index, visibility);
        }
      },
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 800, // Uniform minimum height for all sections
        ),
        color: color ?? Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            TitleText(prefix: '', title: title),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            if (contentType == 'skills')
              const SkillsSection()
            else
              InformationGrid(contentType: contentType ?? 'projects')
          ],
        ),
      ),
    );
  }
}
