import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:personal_portfolio/main.dart';
import 'package:personal_portfolio/widgets/stacked_section.dart';

void main() {
  testWidgets(
    'short panels keep their natural height and reverse their overlap',
    (tester) async {
      final scroll = StackedScrollController();
      addTearDown(scroll.dispose);
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomScrollView(
              controller: scroll,
              paintOrder: SliverPaintOrder.lastIsTop,
              slivers: const [
                StackedSectionSliver(
                  enabled: true,
                  child: SizedBox(key: ValueKey('short'), height: 200),
                ),
                StackedSectionSliver(
                  enabled: true,
                  pin: false,
                  child: SizedBox(key: ValueKey('next'), height: 800),
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final first = tester.renderObject<RenderStackedSection>(
        find.byType(StackedSectionSliver).first,
      );
      expect(first.panelExtent, 200);
      scroll.jumpTo(100);
      await tester.pumpAndSettle();
      expect(
        tester.getTopLeft(find.byKey(const ValueKey('short'))).dy,
        closeTo(3.3, .01),
      );
      expect(tester.getTopLeft(find.byKey(const ValueKey('next'))).dy, 100);
      expect(first.coverProgress, .5);
      scroll.jumpTo(0);
      await tester.pumpAndSettle();
      expect(first.coverProgress, 0);
      expect(tester.getTopLeft(find.byKey(const ValueKey('next'))).dy, 200);
      expect(tester.takeException(), isNull);
    },
  );
  testWidgets(
    'panels pin, overlap in order, reverse, and expose tall content',
    (tester) async {
      tester.view.physicalSize = const Size(1000, 600);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final scroll = StackedScrollController();
      addTearDown(scroll.dispose);
      var trailingTaps = 0, contactTaps = 0;
      final keys = List.generate(3, (_) => GlobalKey());
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomScrollView(
              controller: scroll,
              paintOrder: SliverPaintOrder.lastIsTop,
              slivers: [
                StackedSectionSliver(
                  key: keys[0],
                  enabled: true,
                  child: const ColoredBox(
                    color: Colors.red,
                    child: SizedBox(height: 600, child: Text('Hero panel')),
                  ),
                ),
                StackedSectionSliver(
                  key: keys[1],
                  enabled: true,
                  child: ColoredBox(
                    color: Colors.green,
                    child: SizedBox(
                      height: 1000,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Tall panel'),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: TextButton(
                              onPressed: () => trailingTaps++,
                              child: const Text('Read trailing content'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                StackedSectionSliver(
                  key: keys[2],
                  enabled: true,
                  pin: false,
                  child: ColoredBox(
                    color: Colors.blue,
                    child: SizedBox(
                      height: 600,
                      child: Center(
                        child: TextButton(
                          onPressed: () => contactTaps++,
                          child: const Text('Contact action'),
                        ),
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: ColoredBox(
                    color: Colors.white,
                    child: SizedBox(
                      key: ValueKey('test-footer'),
                      height: 100,
                      child: Text('Footer'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      RenderStackedSection panel(int i) =>
          keys[i].currentContext!.findRenderObject()! as RenderStackedSection;
      // Exercise the actual scroll gesture recognizer in both directions.
      await tester.drag(find.byType(CustomScrollView), const Offset(0, -140));
      await tester.pumpAndSettle();
      final afterDown = scroll.offset;
      expect(afterDown, greaterThan(0));
      await tester.drag(find.byType(CustomScrollView), const Offset(0, 90));
      await tester.pumpAndSettle();
      expect(scroll.offset, lessThan(afterDown));
      scroll.jumpTo(0);
      await tester.pump();
      expect(panel(0).panelExtent, 600);
      expect(panel(1).panelExtent, 1000);
      scroll.jumpTo(150);
      await tester.pump();
      expect(panel(0).coverProgress, closeTo(.25, .001));
      expect(panel(0).paintScale, lessThan(1));
      expect(tester.getTopLeft(find.text('Tall panel')).dy, closeTo(450, .1));
      scroll.jumpTo(600);
      await tester.pump();
      expect(panel(0).geometry!.visible, isFalse);
      expect(panel(1).coverProgress, 0);
      scroll.jumpTo(1000);
      await tester.pump();
      await tester.tap(find.text('Read trailing content'));
      await tester.pump();
      expect(trailingTaps, 1);
      scroll.jumpTo(1050);
      await tester.pump();
      expect(panel(1).coverProgress, greaterThan(0));
      await tester.ensureVisible(find.text('Read trailing content'));
      await tester.pumpAndSettle();
      expect(scroll.offset, 1000);
      await tester.tap(find.text('Read trailing content'));
      expect(trailingTaps, 2);
      scroll.jumpTo(950);
      await tester.pump();
      expect(panel(1).coverProgress, 0);
      expect(tester.getTopLeft(find.text('Tall panel')).dy, closeTo(-350, .1));
      scroll.jumpTo(0);
      await tester.pump();
      expect(panel(0).coverProgress, 0);
      expect(panel(0).paintScale, 1);
      scroll.jumpTo(scroll.position.maxScrollExtent);
      await tester.pump();
      expect(
        tester.getTopLeft(find.byKey(const ValueKey('test-footer'))).dy,
        closeTo(500, .1),
      );
      await tester.tap(find.text('Contact action'));
      await tester.pump();
      expect(contactTaps, 1);
      expect(tester.takeException(), isNull);
    },
  );
  testWidgets('desktop anchors, resize, and footer remain reachable', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(PortfolioApp(openLink: (_) async => true));
    await tester.pumpAndSettle();
    final panels = find.byType(StackedSectionSliver, skipOffstage: false);
    final semantics = tester.ensureSemantics();
    expect(
      tester.getSemantics(find.byType(LinearProgressIndicator)).label,
      'Page scroll progress',
    );
    semantics.dispose();
    final first = tester.renderObject<RenderStackedSection>(panels.first);
    expect(first.enabled, isTrue);
    await tester.ensureVisible(find.text('Explore my work'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Explore my work'));
    await tester.pumpAndSettle();
    final scroll = tester
        .widget<CustomScrollView>(
          find.byKey(const ValueKey('portfolio-scroll')),
        )
        .controller!;
    final projects = tester.renderObject<RenderStackedSection>(panels.at(3));
    expect(scroll.offset, closeTo(projects.scrollStart, .1));
    await tester.tap(find.widgetWithText(TextButton, 'Home'));
    await tester.pumpAndSettle();
    expect(scroll.offset, 0);
    await tester.ensureVisible(find.text('Contact me'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Contact me'));
    await tester.pumpAndSettle();
    expect(
      find.text('Copy message & open LinkedIn').hitTestable(),
      findsOneWidget,
    );
    tester.view.physicalSize = const Size(375, 900);
    await tester.pumpAndSettle();
    expect(
      tester.renderObject<RenderStackedSection>(panels.first).enabled,
      isFalse,
    );
    scroll.jumpTo(scroll.position.maxScrollExtent);
    await tester.pumpAndSettle();
    expect(
      find.text('Built with Flutter. Made with care.').hitTestable(),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });
  testWidgets('reduced motion always uses natural non-pinned scrolling', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    tester.platformDispatcher.accessibilityFeaturesTestValue =
        const FakeAccessibilityFeatures(disableAnimations: true);
    addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);
    await tester.pumpWidget(PortfolioApp(openLink: (_) async => true));
    await tester.pumpAndSettle();
    for (final element
        in find.byType(StackedSectionSliver, skipOffstage: false).evaluate()) {
      expect(
        (element.findRenderObject()! as RenderStackedSection).enabled,
        isFalse,
      );
    }
    expect(tester.takeException(), isNull);
  });
}
