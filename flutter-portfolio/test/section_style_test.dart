import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:personal_portfolio/design/section_style.dart';
import 'package:personal_portfolio/design/theme.dart';
import 'package:personal_portfolio/widgets/section_surface.dart';

double ratio(Color a, Color b) {
  final x = a.computeLuminance(), y = b.computeLuminance();
  return ((x > y ? x : y) + .05) / ((x < y ? x : y) + .05);
}

void main() {
  test(
    'all section palettes are distinct, opaque and readable in both modes',
    () {
      for (final brightness in Brightness.values) {
        final backgrounds = <Color>{};
        for (var i = 0; i < SectionStyle.count; i++) {
          final p = SectionStyle.palette(i, brightness);
          final endpoints = SectionStyle.colors(i, brightness);
          backgrounds.add(p.background);
          for (final surface in [...endpoints, p.panel, p.raised]) {
            expect(surface.a, 1);
            for (final foreground in [p.text, p.muted, p.accent, p.violet]) {
              expect(
                ratio(foreground, surface),
                greaterThanOrEqualTo(4.5),
                reason: 'section $i, $brightness',
              );
            }
          }
        }
        expect(backgrounds.length, SectionStyle.count);
      }
    },
  );
  testWidgets(
    'local theme reaches section content without changing outside content',
    (tester) async {
      for (final brightness in Brightness.values) {
        final base = brightness == Brightness.dark
            ? Palette.dark
            : Palette.light;
        await tester.pumpWidget(
          MaterialApp(
            theme: brightness == Brightness.dark
                ? BrandTheme.dark
                : BrandTheme.light,
            home: Scaffold(
              body: Column(
                children: [
                  Builder(
                    builder: (context) => Text(
                      'outside',
                      style: TextStyle(color: Palette.of(context).accent),
                    ),
                  ),
                  SectionSurface(
                    index: 1,
                    stacked: true,
                    builder: (context) => Text(
                      'inside',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(
          tester.widget<Text>(find.text('outside')).style!.color,
          base.accent,
        );
        expect(
          tester.widget<Text>(find.text('inside')).style!.color,
          SectionStyle.palette(1, brightness).accent,
        );
        final decoration =
            tester
                    .widget<DecoratedBox>(
                      find.byKey(const ValueKey('section-surface-1')),
                    )
                    .decoration
                as BoxDecoration;
        expect(decoration.gradient!.colors, SectionStyle.colors(1, brightness));
        expect(tester.takeException(), isNull);
      }
    },
  );
}
