import 'package:flutter/material.dart';
import 'package:portfolio/controllers/views_controller.dart';

import 'package:portfolio/res/responsive.dart';
import 'package:portfolio/views/information/components/title_text.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'components/information_grid.dart';

class InformationSectionView extends StatelessWidget {
  final String title;
  final int index;
  final Color color;
  const InformationSectionView(
      {super.key, required this.title, required this.index, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          if (Responsive.isLargeMobile(context))
            const SizedBox(
              height: 20.0,
            ),
          VisibilityDetector(
            key: Key(index.toString()),
            onVisibilityChanged: (visibilityInfo) {
              var visiblePercentage = visibilityInfo.visibleFraction * 100;
              if (visiblePercentage == 100) {
                context.read<ViewsController>().changeView(index);
              }
            },
            child: TitleText(prefix: '', title: title),
          ),
          const Divider(),
          const SizedBox(
            height: 20.0,
          ),
          const Expanded(
              child: Responsive(
                  desktop: InformationGrid(
                    crossAxisCount: 3,
                    ratio: 1.5,
                  ),
                  extraLargeScreen: InformationGrid(
                    crossAxisCount: 4,
                  ),
                  largeMobile: InformationGrid(crossAxisCount: 1, ratio: 1.8),
                  mobile: InformationGrid(crossAxisCount: 1, ratio: 1.5),
                  tablet: InformationGrid(
                    ratio: 1.4,
                    crossAxisCount: 2,
                  )))
        ],
      ),
    );
  }
}
