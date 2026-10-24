import 'package:flutter/material.dart';

import '../design/section_style.dart';
import '../design/theme.dart';

class SectionSurface extends StatelessWidget {
  const SectionSurface({
    super.key,
    required this.index,
    required this.stacked,
    required this.builder,
  });
  final int index;
  final bool stacked;
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final palette = SectionStyle.palette(index, brightness);
    return Theme(
      data: SectionStyle.theme(index, brightness),
      child: DecoratedBox(
        key: ValueKey('section-surface-$index'),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: SectionStyle.colors(index, brightness),
          ),
          borderRadius: stacked && index > 0
              ? const BorderRadius.vertical(
                  top: Radius.circular(Brand.panelRadius),
                )
              : null,
          border: Border.all(color: palette.border),
        ),
        child: Builder(builder: builder),
      ),
    );
  }
}
