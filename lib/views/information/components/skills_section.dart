import 'package:flutter/material.dart';
import 'package:portfolio/controllers/information_controller.dart';
import 'package:portfolio/res/responsive.dart';
import 'package:provider/provider.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cv = context.watch<InformationController>().cv;
    if (cv == null) return const SizedBox.shrink();

    final skills = cv.skills;
    final isMobile = Responsive.isMobile(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 10 : 20,
        horizontal: isMobile ? 10 : 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Languages Section
          if (skills.languages.isNotEmpty) ...[
            _buildSkillCategory(context, 'Languages', skills.languages),
            SizedBox(height: isMobile ? 20 : 30),
          ],
          // Frameworks Section
          if (skills.frameworks.isNotEmpty) ...[
            _buildSkillCategory(context, 'Frameworks & Technologies', skills.frameworks),
            SizedBox(height: isMobile ? 20 : 30),
          ],
          // Development Practices Section
          if (skills.developmentPractices.isNotEmpty) ...[
            _buildSkillCategory(context, 'Development Practices', skills.developmentPractices),
            SizedBox(height: isMobile ? 20 : 30),
          ],
          // Tools & Libraries Section
          if (skills.toolsAndLibraries.isNotEmpty) ...[
            _buildSkillCategory(context, 'Tools & Libraries', skills.toolsAndLibraries),
          ],
        ],
      ),
    );
  }

  Widget _buildSkillCategory(BuildContext context, String title, List<String> skills) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
                fontSize: isMobile ? 18 : isTablet ? 20 : 24,
              ),
        ),
        SizedBox(height: isMobile ? 15 : 20),
        Wrap(
          spacing: isMobile ? 8 : 15,
          runSpacing: isMobile ? 8 : 15,
          alignment: WrapAlignment.start,
          children: skills.map((skill) => _SkillCard(skill: skill)).toList(),
        ),
      ],
    );
  }
}

class SkillItem {
  final String name;
  final String category;

  SkillItem({required this.name, required this.category});
}

class _SkillCard extends StatefulWidget {
  final String skill;

  const _SkillCard({required this.skill});

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    
    return MouseRegion(
      onEnter: (_) {
        if (!isMobile) {
          setState(() => _isHovered = true);
          _controller.forward();
        }
      },
      onExit: (_) {
        if (!isMobile) {
          setState(() => _isHovered = false);
          _controller.reverse();
        }
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: isMobile ? 1.0 : _scaleAnimation.value,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 12 : isTablet ? 16 : 20,
                vertical: isMobile ? 10 : isTablet ? 12 : 15,
              ),
              constraints: BoxConstraints(
                maxWidth: isMobile ? double.infinity : 300,
                minWidth: isMobile ? 0 : 120,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _isHovered
                      ? [
                          Theme.of(context).colorScheme.primary.withOpacity(0.8),
                          Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                        ]
                      : [
                          Theme.of(context).colorScheme.surface,
                          Theme.of(context).colorScheme.surface.withOpacity(0.8),
                        ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(isMobile ? 12 : 15),
                boxShadow: _isHovered
                    ? [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                          blurRadius: isMobile ? 10 : 15,
                          offset: Offset(0, isMobile ? 3 : 5),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
                          blurRadius: isMobile ? 3 : 5,
                          offset: Offset(0, isMobile ? 1 : 2),
                        ),
                      ],
                border: Border.all(
                  color: _isHovered
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).dividerColor,
                  width: isMobile ? 1.0 : 1.5,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: isMobile ? 16 : isTablet ? 18 : 20,
                    color: _isHovered
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.primary,
                  ),
                  SizedBox(width: isMobile ? 6 : 10),
                  Flexible(
                    child: Text(
                      widget.skill,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: isMobile ? 12 : isTablet ? 13 : 14,
                            color: _isHovered
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.onSurface,
                          ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
