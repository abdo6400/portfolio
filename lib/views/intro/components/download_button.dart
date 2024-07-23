import 'package:flutter/material.dart';
import 'package:portfolio/res/responsive.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../controllers/information_controller.dart';

class DownloadButton extends StatelessWidget {
  const DownloadButton({super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        launchUrl(Uri.parse(
          context
              .read<InformationController>()
              .cv!
              .additionalInformation
              .socialLinks
              .cv,
        ));
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
            vertical: 20.0 / 1.5, horizontal: 20.0 * 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(color: Colors.blue, offset: Offset(0, -1), blurRadius: 5),
            BoxShadow(color: Colors.red, offset: Offset(0, 1), blurRadius: 5),
          ],
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.pink,
                Colors.blue.shade900,
              ]),
        ),
        child: Row(
          children: [
            Text(
              'Download CV',
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: Colors.white,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 20.0 / 3,
            ),
            const Icon(
              Icons.download,
              color: Colors.white70,
              size: 15,
            )
          ],
        ),
      ).increaseSizeOnHover(1.1),
    );
  }
}
