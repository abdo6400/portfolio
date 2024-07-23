import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/views/projects/components/title_text.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../controllers/views_controller.dart';
import '../../res/constants.dart';
import '../../res/responsive.dart';
import 'components/certification_grid.dart';

class Certifications extends StatelessWidget {
  const Certifications({super.key});
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
          key: Key(2.toString()),
          onVisibilityChanged: (visibilityInfo) {
            var visiblePercentage = visibilityInfo.visibleFraction * 100;
            if (visiblePercentage == 100) {
              context.read<ViewsController>().changeView(2);
            }
          },
          child: const TitleText(prefix: '', title: 'Certifications'),
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        Expanded(
            child: Responsive(
                desktop: CertificateGrid(
                  crossAxisCount: 3,
                  ratio: 1.5,
                ),
                extraLargeScreen:
                    CertificateGrid(crossAxisCount: 4, ratio: 1.6),
                largeMobile: CertificateGrid(crossAxisCount: 1, ratio: 1.8),
                mobile: CertificateGrid(crossAxisCount: 1, ratio: 1.4),
                tablet: CertificateGrid(
                  ratio: 1.7,
                  crossAxisCount: 2,
                )))
      ],
    );
  }
}
