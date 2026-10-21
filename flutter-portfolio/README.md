# Abdelrahman Amr — Flutter Web portfolio

Live: https://abdelrahman-amr-flutter.vercel.app/

A bilingual, dark-first portfolio using Flutter Web and Dart. It includes a light theme, sticky navigation with active-section highlighting and scroll progress, a responsive mobile menu, scroll-driven stacked desktop panels, a rotating project showcase, four filterable featured projects, a searchable 19-project archive, image galleries/zoom, opt-in video demos, skills, experience, services, and a validated contact composer. Arabic supports RTL. Existing project/CV configuration and dependencies are preserved; no Flutter packages were added for this redesign.

## Setup and preview

Use the Flutter/Dart versions allowed by pubspec.yaml (the checked SDK was Flutter 3.47.4 / Dart 3.13.3).

```powershell
flutter pub get
flutter run -d chrome --wasm
```

For the actual production renderer, build and serve the release:

```powershell
flutter build web --release --wasm
python tool/preview.py --port 5314
```

The preview binds to 127.0.0.1 and sets COOP/COEP headers. The release build emits WebAssembly and a JavaScript fallback for browsers without WasmGC. The browser console reports the selected compilation target once at startup. The project does not claim a measured 60 FPS or a universal Wasm speedup.

## Verification

```powershell
./tool/verify.ps1
```

This checks formatting, runs Flutter analysis and all tests, and builds the release with --wasm. Tests cover Arabic/RTL, 320px enlarged text, details/gallery enlargement, link failures, project migration/search, slideshow pause and reduced motion, mobile anchors and theme switching, real-project filters, and contact validation/loading/failures/disposal. Release browser QA must also cover desktop, tablet, mobile, keyboard focus, anchor offsets, theme contrast, and console errors.

There is no supplied automated architecture checker. Manually review content independence, page composition, service ownership of external I/O, shared design tokens, and controller/listener cleanup.

## Architecture and files

- lib/main.dart: locale/theme state, app wiring, runtime target log.
- lib/design/theme.dart: light/dark palettes, typography, layout/motion tokens, control themes.
- lib/content/portfolio_content.dart, all_projects.dart, project_media.dart: verified professional/project records and original galleries.
- lib/content/studio_content.dart: bilingual section copy, skills, services, configurable contact links.
- lib/content/project_covers.dart: generated map of lightweight cover images.
- lib/pages/portfolio_page.dart: sticky navigation, untransformed section anchors, responsive panel composition and scroll state.
- lib/pages/portfolio_sections.dart: hero, about, skills, experience, services, contact.
- lib/pages/project_archive.dart: lazy searchable project grid.
- lib/widgets/brand_widgets.dart: shared layout, typography, gradient heading, chips and interactive project cards.
- lib/widgets/hero_showcase.dart: rotating showcase, pause/focus/lifecycle/reduced-motion handling.
- lib/widgets/featured_projects.dart: category filtering for the four selected projects.
- lib/widgets/section_reveal.dart: finite fallback fades with stable keyboard/anchor geometry.
- lib/widgets/project_details.dart and project_gallery.dart: project modal, image navigation/zoom, user-started videos.
- lib/widgets/contact_form.dart and lib/services/contact_service.dart: validation, draft preparation, clipboard/link failure handling.
- lib/services/link_service.dart: validated external HTTP(S)/mailto launching.
- assets/covers/: generated WebP previews. Original galleries remain in assets/projects/.
- tool/verify.ps1, package.ps1, deploy.ps1, vercel-output.json, preview.py: checks, clean static packaging, hosting headers, deployment and preview.
- tool/optimize_covers.py: optional Pillow-based preview generation; generated covers are committed, so normal builds do not require Pillow.
- web/index.html and manifest.json: page/social metadata, canonical URL, icon and theme configuration.
- test/: regression and interaction tests.

## Content, links and contact behavior

The site uses the supplied CV, existing portfolio assets, and the owner's LinkedIn role verified on 21 October 2026: Senior Flutter Developer at digitalH, August 2026-present. Existing employers, education, project names and dates are preserved. No client counts, results, testimonials or unverified credentials are invented. Statistics are the actual 19 archived projects and two portfolio languages.

The supplied CV is unchanged and predates digitalH. Historical CV/LinkedIn month differences are represented with years for LEAPTECH and ProsysJo. The public email remains unconfirmed; no email address is guessed.

The contact form validates name, email and message, copies a draft locally, and opens LinkedIn. It never claims to send a message. Nothing is stored or submitted to a form backend; visitors must paste and send in LinkedIn themselves. Copy/link failures produce explicit feedback. Length limits and a single pending action prevent oversized drafts and duplicate clicks; a future real form endpoint needs server-side validation, rate limits and spam protection before enabling submission.

Edit ContactLinks in lib/content/studio_content.dart for social destinations. To display an email link after confirming the owner's email, build with:

```powershell
flutter build web --release --wasm --dart-define=PORTFOLIO_EMAIL=your-confirmed-address@example.com
```

The email link opens the visitor's email application; it does not send automatically. EN/AR and theme choices apply to the current session. Query links: ?lang=ar and ?project=addustour (any archive project ID is supported).

## Performance and motion

One scroll listener measures section visibility and updates small notifiers for navigation/progress; the full page does not rebuild per scroll tick. Desktop panel motion is computed in native sliver layout/paint, with cached section children. Fallback fades run once with stable geometry and respect reduced motion. Hover is short and local. There is no scroll hijacking, large blur, video background, or extra animation package. Timers, scroll/page/video controllers and listeners are disposed; autoplay pauses for focus/hover/background lifecycle.

The archive builds grid entries lazily. Fifteen cover originals totaling 17,171,234 bytes have WebP previews totaling 861,876 bytes; original media loads in the gallery when requested. Videos initialize only on Play. Static files are served from the same origin.

## Vercel deployment

```powershell
vercel login
vercel link --project abdelrahman-amr-flutter --scope abdelrahman-amrs-projects
./tool/deploy.ps1
```

The deploy script verifies/builds, replaces only this project's generated .vercel/output directory, packages build/web as static output, applies tool/vercel-output.json, and deploys with vercel deploy --prebuilt --prod --yes. To package an already verified build, run tool/package.ps1, then that deploy command. The output sets Cross-Origin-Embedder-Policy: credentialless and Cross-Origin-Opener-Policy: same-origin for threaded Wasm rendering. Verify these headers and application/wasm on the deployed main.dart.wasm response. Do not disable deployment protection to test previews.

Static hosting needs no backend or secret environment variables. Automatic Git-triggered Vercel compilation is not configured. Keep .env*, .vercel/, .dart_tool/ and build/ out of source commits. The existing React app/GitHub Pages deployment at the repository root is separate.

Official references: https://docs.flutter.dev/deployment/web and https://docs.flutter.dev/platform-integration/web/wasm; Vercel Build Output configuration: https://vercel.com/docs/build-output-api/configuration.

## Stacked scrolling

`lib/widgets/stacked_section.dart` contains a native RenderSliver implementation and its focus-aware ScrollController. It uses CustomScrollView with SliverPaintOrder.lastIsTop, so incoming panels paint and hit-test above previous panels. There is one page scroll container and no CSS/HTML integration, wheel interception, artificial scroll speed, autoplay section transition, or extra dependency.

On viewports at least 1000px wide and 640px high with ordinary text scaling, each main panel is at least one available viewport tall. A tall panel first scrolls through all its content; its final viewport then pins while the next panel slides over it. Scroll progress drives a restrained 2.2% scale reduction and a light dimming behind the incoming panel. Reversing scroll reverses the same calculation. Covered panels stop painting/hit-testing. Contact covers Services, then scrolls naturally into the footer.

Navigation uses each sliver's layout scrollStart instead of transformed screen positions. Keyboard/focus reveals clamp to the readable portion of pinned sections. Mobile/tablet, short windows, enlarged text, and reduced-motion preferences use normal scrolling; this avoids unreadable pinned content and scroll traps. Resizing recalculates viewport extents. There are no new controllers/tickers for the effect, and owned scroll/layer resources are disposed.

Tests cover panel ordering, partial coverage, reverse scrolling, tall trailing content, focus reveal after overlap, desktop navigation in both directions, responsive fallback, reduced motion, Contact and the footer. Release browser QA must still verify real wheel/touch/keyboard behavior; automated tests are not an FPS benchmark.
