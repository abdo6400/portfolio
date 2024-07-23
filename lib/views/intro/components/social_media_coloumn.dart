import 'package:flutter/material.dart';
import 'package:portfolio/views/intro/components/social_icon.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../controllers/information_controller.dart';

class SocialMediaIconColumn extends StatelessWidget {
  const SocialMediaIconColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SocialMediaIcon(
            icon: 'assets/icons/linkedin.svg',
            onTap: () => launchUrl(Uri.parse(context
                .read<InformationController>()
                .cv!
                .additionalInformation
                .socialLinks
                .linkedin))),
        SocialMediaIcon(
          icon: 'assets/icons/github.svg',
          onTap: () => launchUrl(Uri.parse(context
              .read<InformationController>()
              .cv!
              .additionalInformation
              .socialLinks
              .github)),
        ),
        const SocialMediaIcon(icon: 'assets/icons/twitter.svg'),
        const SocialMediaIcon(icon: 'assets/icons/linkedin.svg'),
      ],
    );
  }
}
