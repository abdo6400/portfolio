import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portfolio/controllers/information_controller.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactIcon extends StatelessWidget {
  const ContactIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      child: Row(
        children: [
          const Spacer(),
          IconButton(
              onPressed: () {
                launchUrl(Uri.parse(context
                    .read<InformationController>()
                    .cv!
                    .additionalInformation
                    .socialLinks
                    .linkedin));
              },
              icon: SvgPicture.asset('assets/icons/linkedin.svg')),
          IconButton(
              onPressed: () {
                launchUrl(Uri.parse(context
                    .read<InformationController>()
                    .cv!
                    .additionalInformation
                    .socialLinks
                    .github));
              },
              icon: SvgPicture.asset('assets/icons/github.svg')),
          const Spacer(),
        ],
      ),
    );
  }
}
