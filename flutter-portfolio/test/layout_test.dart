import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:personal_portfolio/design/theme.dart';
import 'package:personal_portfolio/main.dart';
import 'package:personal_portfolio/widgets/brand_widgets.dart';
import 'package:personal_portfolio/widgets/stacked_section.dart';

double contrast(Color a, Color b) {
  final first = a.computeLuminance();
  final second = b.computeLuminance();
  return ((first > second ? first : second) + .05) /
      ((first < second ? first : second) + .05);
}

void main() {
  test('both palettes keep text and accents readable on all surfaces', () {
    for (final palette in [Palette.dark, Palette.light]) {
      for (final foreground in [
        palette.text,
        palette.muted,
        palette.accent,
        palette.violet,
      ]) {
        for (final surface in [
          palette.background,
          palette.panel,
          palette.raised,
        ]) {
          expect(contrast(foreground, surface), greaterThanOrEqualTo(4.5));
        }
      }
    }
  });
  testWidgets(
    'short content stays top-aligned in full-height panels in both directions',
    (tester) async {
      for (final direction in TextDirection.values) {
        await tester.pumpWidget(
          MaterialApp(
            home: Directionality(
              textDirection: direction,
              child: const Scaffold(
                body: SizedBox(
                  height: 600,
                  width: double.infinity,
                  child: ContentWidth(
                    vertical: 24,
                    child: SizedBox(
                      key: ValueKey('content'),
                      height: 80,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(tester.getTopLeft(find.byKey(const ValueKey('content'))).dy, 24);
        expect(
          tester.getSize(find.byKey(const ValueKey('content'))).height,
          80,
        );
        expect(tester.takeException(), isNull);
      }
    },
  );
  testWidgets('balanced panel alignment is opt-in and preserves content size', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SizedBox(
            height: 600,
            child: ContentWidth(
              vertical: 24,
              alignment: Alignment(0, -.2),
              child: SizedBox(
                key: ValueKey('balanced'),
                height: 80,
                width: double.infinity,
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      tester.getTopLeft(find.byKey(const ValueKey('balanced'))).dy,
      closeTo(212.8, .1),
    );
    expect(tester.getSize(find.byKey(const ValueKey('balanced'))).height, 80);
    expect(tester.takeException(), isNull);
  });
  testWidgets(
    'desktop panels fill the viewport while compact layouts stay natural',
    (tester) async {
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);
      for (final width in [1000.0, 1440.0]) {
        tester.view.physicalSize = Size(width, 1200);
        await tester.pumpWidget(PortfolioApp(openLink: (_) async => true));
        await tester.pumpAndSettle();
        final panel = tester.renderObject<RenderStackedSection>(
          find.byType(StackedSectionSliver, skipOffstage: false).first,
        );
        expect(panel.enabled, width >= Brand.stackMinWidth);
        if (panel.enabled) {
          expect(
            panel.panelExtent,
            greaterThanOrEqualTo(panel.constraints.viewportMainAxisExtent),
          );
        } else {
          expect(
            panel.panelExtent,
            lessThan(panel.constraints.viewportMainAxisExtent),
          );
        }
        final headingTop = tester.getTopLeft(find.byType(GradientHeading)).dy;
        expect(headingTop, lessThan(width >= Brand.stackMinWidth ? 450 : 220));
        expect(
          headingTop + tester.getSize(find.byType(GradientHeading)).height,
          lessThan(800),
        );
        expect(tester.takeException(), isNull);
      }
    },
  );
}
