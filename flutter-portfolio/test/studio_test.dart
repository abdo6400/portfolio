import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:personal_portfolio/main.dart';
import 'package:personal_portfolio/services/contact_service.dart';
import 'package:personal_portfolio/widgets/contact_form.dart';
import 'package:personal_portfolio/widgets/featured_projects.dart';
import 'package:personal_portfolio/widgets/brand_widgets.dart';
import 'package:personal_portfolio/widgets/hero_showcase.dart';
import 'package:personal_portfolio/design/theme.dart';

void main() {
  const draft = ContactDraft(
    name: 'A visitor',
    email: 'visitor@example.com',
    message: 'I would like to discuss a Flutter application.',
  );
  test(
    'contact preparation copies a draft and reports link failure honestly',
    () async {
      String? copied;
      final result = await ContactService.prepare(
        draft,
        destination: Uri.parse('https://www.linkedin.com/'),
        copy: (text) async => copied = text,
        openLink: (_) async => false,
      );
      expect(copied, contains(draft.email));
      expect(copied, contains(draft.message));
      expect(result, ContactResult.linkUnavailable);
      var opened = false;
      final failed = await ContactService.prepare(
        draft,
        destination: Uri.parse('https://www.linkedin.com/'),
        copy: (_) async => throw StateError('Clipboard unavailable'),
        openLink: (_) async {
          opened = true;
          return true;
        },
      );
      expect(failed, ContactResult.failed);
      expect(opened, isFalse);
    },
  );
  testWidgets('contact validation, pending state, and success feedback work', (
    tester,
  ) async {
    final pending = Completer<ContactResult>();
    var calls = 0;
    await tester.pumpWidget(
      MaterialApp(
        theme: BrandTheme.dark,
        home: Scaffold(
          body: SingleChildScrollView(
            child: ContactForm(
              arabic: false,
              onPrepare: (_) {
                calls++;
                return pending.future;
              },
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Copy message & open LinkedIn'));
    await tester.pumpAndSettle();
    expect(find.text('Please enter your name.'), findsOneWidget);
    expect(find.text('Enter a valid email address.'), findsOneWidget);
    expect(calls, 0);
    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), draft.name);
    await tester.enterText(fields.at(1), draft.email);
    await tester.enterText(fields.at(2), draft.message);
    await tester.ensureVisible(find.text('Copy message & open LinkedIn'));
    await tester.tap(find.text('Copy message & open LinkedIn'));
    await tester.pump();
    expect(calls, 1);
    expect(find.text('Preparing your message…'), findsOneWidget);
    pending.complete(ContactResult.prepared);
    await tester.pumpAndSettle();
    expect(
      find.text('Message copied. Paste it into LinkedIn to send it.'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });
  testWidgets('a pending form can be removed safely', (tester) async {
    final pending = Completer<ContactResult>();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: ContactForm(arabic: false, onPrepare: (_) => pending.future),
          ),
        ),
      ),
    );
    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), draft.name);
    await tester.enterText(fields.at(1), draft.email);
    await tester.enterText(fields.at(2), draft.message);
    await tester.ensureVisible(find.text('Copy message & open LinkedIn'));
    await tester.tap(find.text('Copy message & open LinkedIn'));
    await tester.pump();
    await tester.pumpWidget(const SizedBox());
    pending.complete(ContactResult.failed);
    await tester.pump();
    expect(tester.takeException(), isNull);
  });
  testWidgets('mobile navigation reaches its section and theme toggle works', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(375, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(PortfolioApp(openLink: (_) async => true));
    await tester.pumpAndSettle();
    expect(
      Theme.of(tester.element(find.byType(BrandIdentity))).brightness,
      Brightness.dark,
    );
    await tester.tap(find.byKey(const ValueKey('theme-toggle')));
    await tester.pumpAndSettle();
    expect(
      Theme.of(tester.element(find.byType(BrandIdentity))).brightness,
      Brightness.light,
    );
    final headerY = tester.getTopLeft(find.byType(BrandIdentity)).dy;
    await tester.tap(find.byKey(const ValueKey('mobile-menu')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Skills').hitTestable());
    await tester.pumpAndSettle();
    expect(find.text('Home'), findsNothing);
    expect(tester.getTopLeft(find.byType(BrandIdentity)).dy, headerY);
    final title = find.text('A focused stack.\nA broader perspective.');
    expect(tester.getTopLeft(title).dy, greaterThan(60));
    expect(tester.getTopLeft(title).dy, lessThan(200));
    expect(tester.takeException(), isNull);
  });
  testWidgets('featured filters show the appropriate real project', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: BrandTheme.dark,
        home: Scaffold(
          body: SingleChildScrollView(
            child: FeaturedProjects(
              arabic: false,
              onProject: (_) {},
              onArchive: () {},
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(ProjectCard), findsNWidgets(4));
    await tester.tap(find.widgetWithText(ChoiceChip, 'Financial services'));
    await tester.pumpAndSettle();
    expect(find.byType(ProjectCard), findsOneWidget);
    expect(find.text('SADAD'), findsOneWidget);
    await tester.tap(find.widgetWithText(ChoiceChip, 'News & media'));
    await tester.pumpAndSettle();
    expect(find.text('ADDUSTOUR'), findsOneWidget);
  });
  testWidgets('reduced motion disables slideshow autoplay', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(disableAnimations: true),
          child: Scaffold(
            body: SizedBox(
              width: 500,
              child: HeroShowcase(arabic: false, wide: true, onProject: (_) {}),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 12));
    expect(
      tester
          .widget<Text>(find.byKey(const ValueKey('showcase-project-name')))
          .data,
      'ADDUSTOUR',
    );
    expect(find.byTooltip('Pause slideshow'), findsNothing);
  });
}
