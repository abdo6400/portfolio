import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:personal_portfolio/content/all_projects.dart';
import 'package:personal_portfolio/content/featured_projects.dart';
import 'package:personal_portfolio/content/project_covers.dart';
import 'package:personal_portfolio/design/theme.dart';
import 'package:personal_portfolio/main.dart';
import 'package:personal_portfolio/pages/project_archive.dart';
import 'package:personal_portfolio/widgets/brand_widgets.dart';
import 'package:personal_portfolio/widgets/hero_showcase.dart';
import 'package:personal_portfolio/widgets/project_gallery.dart';

void main() {
  test('migration includes mobile, backend, game, IoT, and research work', () {
    expect(allProjects.length, 19);
    expect(allProjects.any((p) => p.id == 'thamin'), isTrue);
    expect(featuredProjects.map((p) => p.id), [
      'addustour',
      'albasheq',
      'sadad',
      'pack-and-go',
    ]);
    expect(allProjects.map((p) => p.id).toSet().length, 19);
    expect(allProjects.any((p) => p.name == 'E-commerce Backend API'), isTrue);
    expect(allProjects.any((p) => p.name == 'IoT Parking System'), isTrue);
    expect(
      allProjects.any((p) => p.images.any((m) => m.endsWith('.mp4'))),
      isTrue,
    );
  });

  testWidgets(
    'gallery advances, opens a larger image, and returns to project',
    (tester) async {
      await tester.pumpWidget(PortfolioApp(openLink: (_) async => true));
      await tester.pumpAndSettle();
      await tester.ensureVisible(
        find.byType(ProjectCard, skipOffstage: false).first,
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byType(ProjectCard, skipOffstage: false).first);
      await tester.pumpAndSettle();
      expect(find.text('1 / 9'), findsOneWidget);
      final preview = tester.widget<ProjectImage>(
        find
            .descendant(
              of: find.byType(ProjectGallery),
              matching: find.byType(ProjectImage),
            )
            .first,
      );
      expect(preview.asset, projectCovers['addustour']);
      expect(preview.fallbackAsset, allProjects.first.images.first);
      await tester.tap(find.byTooltip('Open larger image').hitTestable().first);
      await tester.pumpAndSettle();
      final zoomed = tester.widget<Image>(
        find
            .descendant(
              of: find.byType(InteractiveViewer),
              matching: find.byType(Image),
            )
            .first,
      );
      expect(
        (zoomed.image as AssetImage).assetName,
        allProjects.first.images.first,
      );
      await tester.tap(find.byTooltip('Close project').hitTestable().first);
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Next image'));
      await tester.pumpAndSettle();
      expect(find.text('2 / 9'), findsOneWidget);
      await tester.tap(find.byTooltip('Open larger image').hitTestable().first);
      await tester.pumpAndSettle();
      expect(find.byType(InteractiveViewer), findsOneWidget);
      await tester.tap(find.byTooltip('Close project').hitTestable().first);
      await tester.pumpAndSettle();
      expect(find.text('2 / 9'), findsOneWidget);
    },
  );

  testWidgets(
    'project preview falls back when its optimized image is missing',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              child: ProjectImage(
                asset: 'assets/covers/missing.webp',
                fallbackAsset: 'assets/covers/addustour.webp',
                label: 'preview',
                arabic: false,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Image &&
              widget.image is AssetImage &&
              (widget.image as AssetImage).assetName ==
                  'assets/covers/addustour.webp',
        ),
        findsOneWidget,
      );
      expect(find.text('Project image unavailable'), findsNothing);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              child: ProjectImage(
                asset: 'assets/covers/missing.webp',
                fallbackAsset: 'assets/projects/missing.png',
                label: 'preview',
                arabic: false,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Project image unavailable'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('archive searches all projects and handles no results', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: BrandTheme.light,
        home: ProjectArchive(arabic: false, onProject: (_) {}),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('All projects (19)'), findsOneWidget);
    await tester.enterText(find.byType(TextField), '.NET');
    await tester.pumpAndSettle();
    expect(find.text('E-commerce Backend API'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'no-such-project');
    await tester.pumpAndSettle();
    expect(
      find.text('No matching projects. Try another search.'),
      findsOneWidget,
    );
  });

  testWidgets('showcase rotates and pause prevents subsequent changes', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: BrandTheme.light,
        home: Scaffold(
          body: SizedBox(
            width: 500,
            child: HeroShowcase(arabic: false, wide: true, onProject: (_) {}),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<Text>(find.byKey(const ValueKey('showcase-project-name')))
          .data,
      'ADDUSTOUR',
    );
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<Text>(find.byKey(const ValueKey('showcase-project-name')))
          .data,
      'ALBASHEQ',
    );
    await tester.tap(find.byTooltip('Pause slideshow'));
    await tester.pump(const Duration(seconds: 10));
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<Text>(find.byKey(const ValueKey('showcase-project-name')))
          .data,
      'ALBASHEQ',
    );
  });

  testWidgets(
    'minimal showcase supports swipe, keyboard and opening its title',
    (tester) async {
      String? opened;
      await tester.pumpWidget(
        MaterialApp(
          theme: BrandTheme.light,
          home: Scaffold(
            body: SizedBox(
              width: 500,
              child: HeroShowcase(
                arabic: false,
                wide: true,
                onProject: (project) => opened = project.id,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Selected work'), findsNothing);
      expect(find.byIcon(Icons.radio_button_checked), findsNothing);
      final semantics = tester.ensureSemantics();
      final imageAction = tester.getSemantics(
        find.byKey(const ValueKey('showcase-open-image')),
      );
      expect(imageAction.flagsCollection.isButton, isTrue);
      expect(
        imageAction.getSemanticsData().hasAction(SemanticsAction.tap),
        isTrue,
      );
      expect(imageAction.label, contains('ADDUSTOUR'));
      semantics.dispose();
      final image = tester.widget<Image>(
        find
            .descendant(
              of: find.byKey(const ValueKey('showcase-image')),
              matching: find.byType(Image),
            )
            .first,
      );
      expect(image.fit, BoxFit.contain);
      final gesture = await tester.startGesture(
        tester.getCenter(find.byKey(const ValueKey('showcase-image'))),
      );
      await gesture.moveBy(const Offset(-160, 0));
      await tester.pump(const Duration(seconds: 6));
      expect(
        tester
            .widget<Text>(find.byKey(const ValueKey('showcase-project-name')))
            .data,
        'ADDUSTOUR',
      );
      await gesture.up();
      await tester.pumpAndSettle();
      expect(
        tester
            .widget<Text>(find.byKey(const ValueKey('showcase-project-name')))
            .data,
        'ALBASHEQ',
      );
      await tester.tap(find.byKey(const ValueKey('showcase-project-name')));
      expect(opened, 'albasheq');
      Focus.of(
        tester.element(find.byKey(const ValueKey('showcase-project-name'))),
      ).requestFocus();
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
      await tester.pumpAndSettle();
      expect(
        tester
            .widget<Text>(find.byKey(const ValueKey('showcase-project-name')))
            .data,
        'SADAD',
      );
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('videos wait for user playback', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SizedBox(
            height: 400,
            child: ProjectVideo(
              asset: 'assets/projects/arkanoid-game-00.mp4',
              arabic: false,
              active: true,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Play video'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
