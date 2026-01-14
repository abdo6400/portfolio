import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio/controllers/information_controller.dart';
import 'package:provider/provider.dart';

import '../../../models/project_model.dart';

class ProjectLinks extends StatelessWidget {
  final int index;
  final bool useCvData;
  const ProjectLinks({super.key, required this.index, this.useCvData = false});
  
  @override
  Widget build(BuildContext context) {
    if (useCvData) {
      final cv = context.watch<InformationController>().cv;
      if (cv == null || index >= cv.projects.length) {
        return const SizedBox.shrink();
      }
      final project = cv.projects[index];
      final hasLinks = project.githubLink != null ||
          project.appleStoreLink != null ||
          project.googlePlayLink != null;

      if (!hasLinks) {
        return const SizedBox.shrink();
      }

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (project.githubLink != null)
            _buildLinkButton(
              context,
              'GitHub',
              project.githubLink!,
              'assets/icons/github.svg',
            ),
          if (project.appleStoreLink != null)
            _buildLinkButton(
              context,
              'App Store',
              project.appleStoreLink!,
              null,
              icon: Icons.apple,
            ),
          if (project.googlePlayLink != null)
            _buildLinkButton(
              context,
              'Play Store',
              project.googlePlayLink!,
              null,
              icon: Icons.android,
            ),
        ],
      );
    }

    // Original project list links
    return Row(
      children: [
        Row(
          children: [
            Text(
              'Check on Github',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              overflow: TextOverflow.ellipsis,
            ),
            IconButton(
              onPressed: () {
                launchUrl(Uri.parse(projectList[index].link));
              },
              icon: SvgPicture.asset('assets/icons/github.svg'),
            ),
          ],
        ),
        const Spacer(),
        TextButton(
          onPressed: () {
            launchUrl(Uri.parse(projectList[index].link));
          },
          child: const Text(
            'Read More>>',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.amber,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildLinkButton(
    BuildContext context,
    String label,
    String url,
    String? svgPath, {
    IconData? icon,
  }) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(url)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (svgPath != null)
              SvgPicture.asset(
                svgPath,
                width: 16,
                height: 16,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.onSurface,
                  BlendMode.srcIn,
                ),
              )
            else if (icon != null)
              Icon(icon, size: 16, color: Colors.white),
            const SizedBox(width: 5),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
