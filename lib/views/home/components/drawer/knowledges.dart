import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../controllers/information_controller.dart';

class KnowledgeItem {
  final double percentage;
  final String title;
  final IconData? icon;

  KnowledgeItem({
    required this.percentage,
    required this.title,
    this.icon,
  });
}

class AnimatedLinearProgressIndicator extends StatelessWidget {
  const AnimatedLinearProgressIndicator({
    super.key,
    required this.percentage,
    required this.title,
    this.icon,
  });

  final double percentage;
  final String title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: percentage),
        duration: const Duration(seconds: 1),
        builder: (context, value, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (icon != null)
                    Icon(
                      icon,
                      size: 20,
                      color: Colors.white, // Icon color
                    ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white, // Text color
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    '${(value * 100).toInt()}%',
                    style: const TextStyle(
                        color: Colors.white), // Percentage color
                  ),
                ],
              ),
              const SizedBox(height: 10),
              LinearProgressIndicator(
                value: value,
                backgroundColor: Colors.blue
                    .shade900, // Background color of the progress indicator
                color: Colors.white, // Color of the progress
              ),
            ],
          );
        },
      ),
    );
  }
}

class KnowledgeSection extends StatelessWidget {
  final String title;
  final List<KnowledgeItem> knowledgeList;

  const KnowledgeSection({
    super.key,
    required this.title,
    required this.knowledgeList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.shade900
          .withOpacity(0.1), // Background color for the section
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white, // Section title color
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          ...knowledgeList.map((item) => AnimatedLinearProgressIndicator(
                percentage: item.percentage,
                title: item.title,
                icon: item.icon,
              )),
        ],
      ),
    );
  }
}

class Knowledges extends StatelessWidget {
  const Knowledges({super.key});

  @override
  Widget build(BuildContext context) {
    final cv = context.read<InformationController>().cv!;
    final skills = cv.skills;

    final languages = skills.languages
        .map((language) => KnowledgeItem(
              percentage: 1.0, // 100% for all skills except specific ones
              title: language,
              icon: Icons.language, // Replace with appropriate icons
            ))
        .toList();

    final frameworks = skills.frameworks
        .map((framework) => KnowledgeItem(
              percentage: framework == 'GraphQL'
                  ? 0.6
                  : 1.0, // 100% for all skills except specific ones
              title: framework,
              icon: Icons.code, // Replace with appropriate icons
            ))
        .toList();

    final developmentPractices = skills.developmentPractices
        .map((practice) => KnowledgeItem(
              percentage: 1.0, // 100% for all skills except specific ones
              title: practice,
              icon: Icons.settings, // Replace with appropriate icons
            ))
        .toList();

    final toolsAndLibraries = skills.toolsAndLibraries
        .map((tool) => KnowledgeItem(
              percentage: tool == 'FlutterFlow'
                  ? 0.6
                  : 1.0, // Set 60% for FlutterFlow and GraphQL, 100% otherwise
              title: tool,
              icon: Icons.build, // Replace with appropriate icons
            ))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(color: Colors.white), // Divider color
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'Skills',
            style: TextStyle(
                color: Colors.white, fontSize: 24), // Main title color and size
          ),
        ),
        KnowledgeSection(title: 'Languages', knowledgeList: languages),
        KnowledgeSection(title: 'Frameworks', knowledgeList: frameworks),
        KnowledgeSection(
            title: 'Development Practices',
            knowledgeList: developmentPractices),
        KnowledgeSection(
            title: 'Tools and Libraries', knowledgeList: toolsAndLibraries),
      ],
    );
  }
}
