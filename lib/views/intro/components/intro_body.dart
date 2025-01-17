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
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.1,
            ),
            if (!Responsive.isDesktop(context))
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimatedImageContainer(
                      width: size.width * 0.5,
                      height: size.height * 0.25,
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
            SizedBox(
              height: size.height * 0.01,
            ),
            const CombineSubtitleText(),
            SizedBox(
              height: size.height * 0.02,
            ),
            const Responsive(
              desktop: AnimatedDescriptionText(start: 14, end: 15),
              largeMobile: AnimatedDescriptionText(start: 14, end: 12),
              mobile: AnimatedDescriptionText(start: 14, end: 12),
              tablet: AnimatedDescriptionText(start: 17, end: 14),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            const DownloadButton(),
          ],
        ),
        const Spacer(),
        if (Responsive.isDesktop(context))
          Column(
            children: [
              SizedBox(
                height: size.height * 0.1,
              ),
              const AnimatedImageContainer(),
            ],
          ),
        const Spacer(),
      ],
    );
  }
}
