import 'package:flutter/material.dart';
import 'navigation_button.dart';

class NavigationButtonList extends StatelessWidget {
  const NavigationButtonList({super.key});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 200),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: const Row(
            children: [
              NavigationTextButton(index: 0, text: 'Home'),
              NavigationTextButton(index: 1, text: 'Projects'),
              NavigationTextButton(index: 2, text: 'Certifications'),
            ],
          ),
        );
      },
    );
  }
}
