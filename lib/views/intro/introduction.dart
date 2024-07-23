import 'package:flutter/material.dart';
import 'package:portfolio/res/responsive.dart';
import 'package:portfolio/views/intro/components/intro_body.dart';
import 'package:portfolio/views/intro/components/social_media_list.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../controllers/views_controller.dart';

class Introduction extends StatelessWidget {
  const Introduction({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.02,
        ),
        if (!Responsive.isLargeMobile(context)) const SocialMediaIconList(),
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.07,
        ),
        Expanded(
          child: VisibilityDetector(
            key: Key(0.toString()),
            onVisibilityChanged: (visibilityInfo) {
              var visiblePercentage = visibilityInfo.visibleFraction * 100;
              if (visiblePercentage == 100) {
                context.read<ViewsController>().changeView(0);
              }
            },
            child: IntroBody(),
          ),
        ),
      ],
    );
  }
}
