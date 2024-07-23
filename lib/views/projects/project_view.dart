import 'package:flutter/material.dart';
import 'package:portfolio/controllers/views_controller.dart';
import 'package:portfolio/res/constants.dart';
import 'package:portfolio/res/responsive.dart';
import 'package:portfolio/views/projects/components/title_text.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'components/projects_grid.dart';

class ProjectsView extends StatelessWidget {
  const ProjectsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (Responsive.isLargeMobile(context))
          const SizedBox(
            height: defaultPadding,
          ),
        VisibilityDetector(
          key: Key(1.toString()),
          onVisibilityChanged: (visibilityInfo) {
            var visiblePercentage = visibilityInfo.visibleFraction * 100;
            if (visiblePercentage == 100) {
              context.read<ViewsController>().changeView(1);
            }
          },
          child: const TitleText(prefix: '', title: 'Projects'),
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        Expanded(
            child: Responsive(
                desktop: ProjectGrid(
                  crossAxisCount: 3,
                  ratio: 1.5,
                ),
                extraLargeScreen: ProjectGrid(
                  crossAxisCount: 4,
                ),
                largeMobile: ProjectGrid(crossAxisCount: 1, ratio: 1.8),
                mobile: ProjectGrid(crossAxisCount: 1, ratio: 1.5),
                tablet: ProjectGrid(
                  ratio: 1.4,
                  crossAxisCount: 2,
                )))
      ],
    );
  }
}
