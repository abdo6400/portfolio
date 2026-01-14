import 'package:flutter/material.dart';
import 'package:portfolio/views/information/components/card_link.dart';
import 'package:portfolio/controllers/information_controller.dart';
import 'package:provider/provider.dart';

import '../../../models/project_model.dart';

import '../../../res/responsive.dart';

class Detail extends StatelessWidget {
  final int index;
  final bool useCvData;
  const Detail({super.key, required this.index, this.useCvData = false});
  
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    
    if (useCvData) {
      final cv = context.watch<InformationController>().cv;
      if (cv == null || index >= cv.projects.length) {
        return const SizedBox.shrink();
      }
      final project = cv.projects[index];
      
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project Image if available
          if (project.image != null && project.image!.isNotEmpty) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                project.image!,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 120,
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    child: Icon(Icons.image, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
                  );
                },
              ),
            ),
            const SizedBox(height: 15),
          ],
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              project.name,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          Responsive.isMobile(context)
              ? const SizedBox(height: 10.0)
              : const SizedBox(height: 15.0),
          // Skills used
          if (project.skillsUsed.isNotEmpty) ...[
            Wrap(
              spacing: 5,
              runSpacing: 5,
              children: project.skillsUsed.take(3).map((skill) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    skill,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 10,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
          ],
          const Spacer(),
          ProjectLinks(index: index, useCvData: true),
          const SizedBox(height: 10.0),
        ],
      );
    }
    
    // Original project list display
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Project Image
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            projectList[index].image,
            height: 120,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 120,
                color: Colors.grey[800],
                child: const Icon(Icons.image, color: Colors.grey),
              );
            },
          ),
        ),
        const SizedBox(height: 15),
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            projectList[index].name,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Responsive.isMobile(context)
            ? const SizedBox(height: 10.0)
            : const SizedBox(height: 15.0),
        Text(
          projectList[index].description,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            height: 1.5,
          ),
          maxLines: size.width > 700 && size.width < 750
              ? 3
              : size.width < 470
                  ? 2
                  : size.width > 600 && size.width < 700
                      ? 6
                      : size.width > 900 && size.width < 1060
                          ? 6
                          : 4,
          overflow: TextOverflow.ellipsis,
        ),
        const Spacer(),
        ProjectLinks(index: index),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
