import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:personal_portfolio/main.dart';
import 'package:personal_portfolio/widgets/brand_widgets.dart';

void main() {
  testWidgets('compact English layout supports project details', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(375, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(PortfolioApp(openLink: (_) async => true));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(
      find.text('Senior Flutter Developer at digitalH', skipOffstage: false),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('language-toggle')), findsNothing);
    expect(
      Directionality.of(
        tester.element(find.byType(ProjectCard, skipOffstage: false).first),
      ),
      TextDirection.ltr,
    );
    await tester.ensureVisible(
      find.byType(ProjectCard, skipOffstage: false).first,
    );
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    await tester.tap(find.byType(ProjectCard, skipOffstage: false).first);
    await tester.pumpAndSettle();
    expect(find.text('My contribution'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.tap(find.byTooltip('Close project'));
    await tester.pumpAndSettle();
    expect(find.byType(Dialog), findsNothing);
  });

  testWidgets(
    'wide layout navigates to work and opens the correct project URL',
    (tester) async {
      tester.view.physicalSize = const Size(1440, 1000);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      Uri? opened;
      await tester.pumpWidget(
        PortfolioApp(
          openLink: (uri) async {
            opened = uri;
            return true;
          },
        ),
      );
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('Explore my work'));
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();
      await tester.tap(find.text('Explore my work'));
      await tester.pumpAndSettle();
      await tester.ensureVisible(
        find.byType(ProjectCard, skipOffstage: false).first,
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byType(ProjectCard, skipOffstage: false).first);
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('View app'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('View app'));
      await tester.pumpAndSettle();
      expect(opened?.host, 'apps.apple.com');
      expect(opened?.path, contains('id6444052571'));
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('failed contact links give useful feedback', (tester) async {
    await tester.pumpWidget(PortfolioApp(openLink: (_) async => false));
    await tester.pumpAndSettle();
    final contact = find.text('Connect on LinkedIn', skipOffstage: false);
    await tester.ensureVisible(contact);
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    await tester.tap(contact);
    await tester.pumpAndSettle();
    expect(
      find.text('The link could not be opened. Please try again.'),
      findsOneWidget,
    );
  });

  testWidgets('320px layout stays usable with enlarged text', (tester) async {
    tester.view.physicalSize = const Size(320, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    tester.platformDispatcher.textScaleFactorTestValue = 1.4;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await tester.pumpWidget(PortfolioApp(openLink: (_) async => true));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('Arabic device locale still displays English', (tester) async {
    tester.platformDispatcher.localeTestValue = const Locale('ar');
    addTearDown(tester.platformDispatcher.clearLocaleTestValue);
    await tester.pumpWidget(PortfolioApp(openLink: (_) async => true));
    await tester.pumpAndSettle();
    expect(find.text('Contact me'), findsWidgets);
    expect(find.byKey(const ValueKey('language-toggle')), findsNothing);
    expect(
      Directionality.of(tester.element(find.text('Contact me').first)),
      TextDirection.ltr,
    );
  });
}
