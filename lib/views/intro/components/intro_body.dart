import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../../../res/responsive.dart';
import 'animated_texts_componenets.dart';
import 'combine_subtitle.dart';
import 'description_text.dart';
import 'download_button.dart';
import 'headline_text.dart';

class IntroBody extends StatelessWidget {
  const IntroBody({super.key});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!Responsive.isDesktop(context))
              SizedBox(
                height: size.height * 0.06,
              ),
            if (!Responsive.isDesktop(context))
              const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimatedImageContainer(
                      width: 200,
                      height: 200,
                    ),
                  ]),
            if (!Responsive.isDesktop(context))
              SizedBox(
                height: size.height * 0.1,
              ),
            const Responsive(
                desktop: MyPortfolioText(start: 40, end: 50),
                largeMobile: MyPortfolioText(start: 40, end: 35),
                mobile: MyPortfolioText(start: 35, end: 30),
                tablet: MyPortfolioText(start: 50, end: 40)),
            if (kIsWeb && Responsive.isLargeMobile(context))
              Container(
                height: 20.0,
                color: Colors.transparent,
              ),
            const CombineSubtitleText(),
            const SizedBox(height: 20.0 / 2),
            const Responsive(
              desktop: AnimatedDescriptionText(start: 14, end: 15),
              largeMobile: AnimatedDescriptionText(start: 14, end: 12),
              mobile: AnimatedDescriptionText(start: 14, end: 12),
              tablet: AnimatedDescriptionText(start: 17, end: 14),
            ),
            const SizedBox(
              height: 20.0 * 2,
            ),
            const DownloadButton(),
          ],
        ),
        const Spacer(),
        if (Responsive.isDesktop(context)) const AnimatedImageContainer(),
        const Spacer()
      ],
    );
  }
}
