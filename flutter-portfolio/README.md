# Abdelrahman Amr — Flutter portfolio

Bilingual portfolio for employment and freelance audiences, built with Flutter Web and Dart. The original website at D:/work/portfolio is unchanged.

The homepage highlights four projects, with a searchable archive containing all 19 projects from the original portfolio. Project galleries include thumbnails, swipe/arrow navigation, larger image viewing, and user-initiated video demos. The rotating showcase changes every five seconds, pauses during hover/focus or when the app is hidden, and respects reduced-motion settings. The header uses the existing photo and name. Shared theme tokens use navy, blue, and soft white.

## Run

```powershell
flutter pub get
flutter run -d web-server --web-hostname 127.0.0.1 --web-port 5314
```

For a release preview, build and serve build/web with a static HTTP server.

```powershell
flutter build web --release
python -m http.server 5314 --bind 127.0.0.1 --directory build/web
```

## Validation

```powershell
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test
flutter build web --release
```

The nine tests cover mobile Arabic layout and RTL direction, project details and image enlargement, correct project links, failed-link feedback, 320px enlarged-text layout, complete project migration, archive search and empty results, slideshow rotation/pause, and videos waiting for user interaction. Run `tool/verify.ps1` for the full command sequence. Perform desktop/mobile browser inspection as well; widget tests do not establish browser compatibility or real external-link availability.

## Structure

- lib/content: bilingual copy and factual project/experience records; no widget or service dependencies.
- lib/design: shared colors, typography, spacing, radii, and button styling.
- lib/services: external-link launching and failure handling; no UI dependencies.
- lib/widgets: shared presentation components using content and design.
- lib/pages: page composition, scrolling, and project dialogs. Link actions are injected.
- lib/main.dart: locale state and dependency wiring.

No automated architecture checker was supplied. Review import direction, service isolation, content centralization, and shared-widget use explicitly before release.

## Content and links

English is the default. The language switch sets Arabic locale and RTL direction. Add `?lang=ar` to open Arabic directly. Project deep links use `?project=addustour`, `?project=thamin`, `?project=sadad`, or `?project=pack-and-go`. Combine parameters, for example `?lang=ar&project=addustour`.

Content comes from the supplied CV and the user's LinkedIn profile, read on 21 October 2026. The current role is Senior Flutter Developer at digitalH, August 2026-present. Two historical end dates differ between the CV and LinkedIn, so the portfolio uses years for LEAPTECH and ProsysJo until confirmed. Product features are distinguished from the developer's contribution. No audience, revenue, performance, or AI-model-development claims are invented.

The public Pack and Go repository was inspected for folder structure, both dependency manifests, and both entry points. Its runtime behavior was not audited.

## Assets

All 71 project images/videos, the profile photo, and the unchanged CV were copied from the existing portfolio. The user explicitly authorized reusing that code and publishing this site. Client and third-party assets retain their existing rights. Videos are not initialized until playback is requested. The archive uses a lazy grid; opening it does not mount every card at once.

## Content follow-ups

- Vercel hosts this Flutter version at the domain returned by the deployment. The existing GitHub Pages site has its own React build and is unchanged.
- Confirm the public email: CV ends in 348, existing portfolio data ends in 346. This site uses LinkedIn as its contact destination.
- Confirm historical employment dates and preferred English/Arabic name spelling.
- Keep new project additions grounded in supplied work; existing source material was authorized for reuse and publication.
- Replace web/cv.pdf with an updated CV including digitalH when responsibilities and dates are confirmed. The current download is the supplied CV, which ends in March 2026.
- Add the final canonical URL and absolute social-preview image once the destination is known. Current metadata includes title, description, and theme color; it does not solve Flutter search-indexing limitations.
- Vercel serves the app at the domain root; use the default `/` base path. A future subdirectory deployment requires a matching `--base-href`.
- Verify asset, CV, language, project-dialog, keyboard, browser-back, and external-link behavior at the deployed path. No analytics or tracking is configured.

## Deploying to Vercel

This site uses Vercel's Build Output API with the locally compiled static files in `.vercel/output/static` and `{"version":3}` in `.vercel/output/config.json`. Run `vercel link` for the intended account/project, then `tool/deploy.ps1`. It validates and builds before uploading only the prebuilt output. Do not commit `.vercel`, `.env*`, `.dart_tool`, or `build`.

Vercel project: `abdelrahman-amr-flutter`, under `abdelrahman-amrs-projects`. The current deploy command is `vercel deploy --prebuilt --prod --yes`. Static hosting requires no application environment variables or server functions. Automatic Git-triggered deployment is not configured; use the documented local build/deploy workflow.
