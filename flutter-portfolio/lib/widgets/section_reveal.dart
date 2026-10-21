import 'package:flutter/material.dart';

import '../design/theme.dart';

/// Paints once per reveal, never on every scroll tick. Geometry is checked by the page.
class SectionReveal extends StatelessWidget {
  const SectionReveal({
    super.key,
    required this.visible,
    required this.child,
    this.stagger = 0,
  });
  final ValueNotifier<bool> visible;
  final Widget child;
  final int stagger;
  @override
  Widget build(BuildContext context) => ValueListenableBuilder<bool>(
    valueListenable: visible,
    child: child,
    builder: (context, shown, child) {
      final reduced = MediaQuery.disableAnimationsOf(context);
      return TweenAnimationBuilder<double>(
        tween: Tween(begin: reduced ? 1 : 0, end: shown || reduced ? 1 : 0),
        duration: reduced ? Duration.zero : Brand.entrance,
        curve: Interval((stagger % 3) * .08, 1, curve: Curves.easeOutCubic),
        child: child,
        // Stable geometry keeps keyboard reveals and mobile anchors accurate.
        // Desktop panel translation is handled directly by the scroll sliver.
        builder: (_, value, child) => Opacity(opacity: value, child: child),
      );
    },
  );
}
