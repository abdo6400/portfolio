import 'package:flutter/material.dart';
import 'package:portfolio/controllers/information_controller.dart';
import 'package:provider/provider.dart';
import 'header_info.dart';

class PersonalInfo extends StatelessWidget {
  const PersonalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final cv = context.read<InformationController>().cv!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20.0 / 2,
        ),
        AreaInfoText(title: 'Contact', text: cv.contactInformation.phone),
        AreaInfoText(title: 'Email', text: cv.contactInformation.email),
        AreaInfoText(
            title: 'LinkedIn',
            text:
                cv.additionalInformation.socialLinks.linkedin.split('/').last),
        AreaInfoText(
            title: 'GitHub',
            text: cv.additionalInformation.socialLinks.github.split("/").last),
        const SizedBox(
          height: 20.0,
        ),
        Text(
          'Skills',
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: Colors.white),
        ),
        const SizedBox(
          height: 20.0,
        ),
      ],
    );
  }
}
