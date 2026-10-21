import 'package:flutter/material.dart';

import '../content/portfolio_content.dart';
import '../content/studio_content.dart';
import '../design/theme.dart';
import '../services/contact_service.dart';
import '../widgets/brand_widgets.dart';
import '../widgets/contact_form.dart';
import '../widgets/hero_showcase.dart';

class PortfolioSections {
  const PortfolioSections({
    required this.arabic,
    required this.onProject,
    required this.onWork,
    required this.onContact,
    required this.openLink,
  });
  final bool arabic;
  final ValueChanged<Project> onProject;
  final VoidCallback onWork, onContact;
  final Future<bool> Function(Uri) openLink;
  String t(Bilingual text) => text.inLanguage(arabic);
  Widget split(
    BuildContext context,
    Widget first,
    Widget second, {
    int firstFlex = 1,
    int secondFlex = 1,
  }) => LayoutBuilder(
    builder: (_, c) => c.maxWidth >= Brand.desktop
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: firstFlex, child: first),
              const SizedBox(width: 56),
              Expanded(flex: secondFlex, child: second),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [first, const SizedBox(height: 28), second],
          ),
  );
  Widget hero(BuildContext context) => LayoutBuilder(
    builder: (_, c) {
      final wide = c.maxWidth >= Brand.desktop;
      final p = Palette.of(context);
      final intro = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: p.raised,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: p.border),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.circle, size: 7, color: p.violet),
                const SizedBox(width: 9),
                Flexible(
                  child: Text(
                    t(StudioCopy.available),
                    style: TextStyle(
                      color: p.text,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          GradientHeading(
            leading: t(StudioCopy.heroLead),
            accent: t(StudioCopy.heroAccent),
            label: t(StudioCopy.hero),
            style:
                (wide
                        ? Theme.of(context).textTheme.displayLarge
                        : Theme.of(context).textTheme.displaySmall)!
                    .copyWith(
                      fontSize: wide ? 62 : (c.maxWidth < 340 ? 37 : 44),
                    ),
          ),
          const SizedBox(height: 22),
          Text(
            t(StudioCopy.intro),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 26),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              FilledButton.icon(
                onPressed: onWork,
                icon: const Icon(Icons.arrow_outward, size: 19),
                label: Text(t(Copy.viewWork)),
              ),
              OutlinedButton(
                onPressed: onContact,
                child: Text(t(StudioCopy.contactMe)),
              ),
            ],
          ),
          const SizedBox(height: 28),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              Text(
                'Flutter / Dart',
                style: TextStyle(
                  color: p.violet,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text('·', style: TextStyle(color: p.muted)),
              Text(
                t(StudioCopy.buildLabel),
                style: TextStyle(color: p.muted, fontSize: 12),
              ),
            ],
          ),
        ],
      );
      final composition = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Row(
              children: [
                Icon(Icons.code, size: 18, color: p.violet),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    t(Copy.role),
                    style: TextStyle(color: p.muted, fontSize: 12),
                  ),
                ),
                Text('01—04', style: TextStyle(color: p.muted, fontSize: 11)),
              ],
            ),
          ),
          HeroShowcase(arabic: arabic, wide: wide, onProject: onProject),
        ],
      );
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (wide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 6, child: intro),
                const SizedBox(width: 64),
                Expanded(flex: 5, child: composition),
              ],
            )
          else ...[
            intro,
            const SizedBox(height: 28),
            composition,
          ],
          const SizedBox(height: 24),
          TextButton.icon(
            onPressed: onWork,
            icon: const Icon(Icons.south, size: 16),
            label: Text(t(StudioCopy.scroll)),
          ),
        ],
      );
    },
  );
  Widget about(BuildContext context) {
    final p = Palette.of(context);
    return split(
      context,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeading(
            index: '01 / ${t(Copy.about)}',
            title: t(StudioCopy.aboutTitle),
          ),
          const SizedBox(height: 22),
          Text(
            t(StudioCopy.aboutBody),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
          Text(t(StudioCopy.location), style: TextStyle(color: p.accent)),
          const SizedBox(height: 24),
          Wrap(
            spacing: 32,
            runSpacing: 20,
            children: [
              _stat(context, '19', t(StudioCopy.publicWork)),
              _stat(context, 'EN / AR', t(StudioCopy.languages)),
            ],
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: () => openLink(Uri.base.resolve('cv.pdf')),
            icon: const Icon(Icons.description_outlined, size: 18),
            label: Text(t(Copy.cv)),
          ),
        ],
      ),
      Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 360),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            border: Border.all(color: p.border),
            borderRadius: BorderRadius.circular(Brand.radius),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [p.raised, p.panel],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/projects/profile.png',
                  height: 280,
                  fit: BoxFit.contain,
                  semanticLabel: t(StudioCopy.profile),
                  errorBuilder: (_, _, _) =>
                      Icon(Icons.person_outline, size: 160, color: p.accent),
                ),
              ),
              const SizedBox(height: 20),
              Text(t(Copy.name), style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 6),
              Text(t(Copy.role)),
            ],
          ),
        ),
      ),
      firstFlex: 3,
      secondFlex: 2,
    );
  }

  Widget _stat(BuildContext context, String value, String label) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        value,
        style: Theme.of(context).textTheme.headlineMedium!
            .copyWith(color: Palette.of(context).violet),
      ),
      const SizedBox(height: 4),
      Text(label, style: Theme.of(context).textTheme.bodySmall),
    ],
  );
  Widget skills(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SectionHeading(
        index: '02 / ${t(StudioCopy.skills)}',
        title: t(StudioCopy.skillsTitle),
        description: t(StudioCopy.skillsBody),
      ),
      const SizedBox(height: 32),
      LayoutBuilder(
        builder: (_, c) {
          final columns = c.maxWidth >= 1000
              ? 4
              : c.maxWidth >= 600
              ? 2
              : 1;
          const icons = [
            Icons.flutter_dash,
            Icons.cloud_outlined,
            Icons.account_tree_outlined,
            Icons.terminal,
          ];
          return Wrap(
            spacing: 24,
            runSpacing: 28,
            children: List.generate(
              skillGroups.length,
              (i) => SizedBox(
                width: (c.maxWidth - (columns - 1) * 24) / columns,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(icons[i], color: Palette.of(context).violet, size: 24),
                    const SizedBox(height: 16),
                    Text(
                      t(skillGroups[i].title),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 7,
                      runSpacing: 9,
                      children: skillGroups[i].items
                          .map((label) => TechnologyChip(label: label))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ],
  );
  Widget journey(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SectionHeading(
        index: '04 / ${t(Copy.experience)}',
        title: t(StudioCopy.journey),
      ),
      const SizedBox(height: 30),
      ...experiences.map(
        (e) => Container(
          margin: const EdgeInsets.only(bottom: 22),
          padding: const EdgeInsetsDirectional.only(
            start: 22,
            top: 4,
            bottom: 22,
          ),
          decoration: BoxDecoration(
            border: BorderDirectional(
              start: BorderSide(color: Palette.of(context).border, width: 2),
            ),
          ),
          child: LayoutBuilder(
            builder: (_, c) {
              final company = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Eyebrow(t(e.period)),
                  const SizedBox(height: 8),
                  Text(
                    e.company,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              );
              final detail = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t(e.role),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(t(e.summary)),
                ],
              );
              return c.maxWidth >= 700
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 260, child: company),
                        Expanded(child: detail),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [company, const SizedBox(height: 12), detail],
                    );
            },
          ),
        ),
      ),
      const Divider(),
      const SizedBox(height: 20),
      Eyebrow(t(StudioCopy.education)),
      const SizedBox(height: 10),
      Text(t(Copy.education)),
    ],
  );
  Widget services(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SectionHeading(
        index: '05 / ${t(StudioCopy.services)}',
        title: t(StudioCopy.servicesTitle),
      ),
      const SizedBox(height: 24),
      LayoutBuilder(
        builder: (_, c) {
          final columns = c.maxWidth >= 700 ? 2 : 1;
          return Wrap(
            spacing: 40,
            runSpacing: 12,
            children: List.generate(
              serviceItems.length,
              (i) => SizedBox(
                width: (c.maxWidth - (columns - 1) * 40) / columns,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 22),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Palette.of(context).border),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '0${i + 1}',
                        style: TextStyle(
                          color: Palette.of(context).violet,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t(serviceItems[i].title),
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 10),
                            Text(t(serviceItems[i].body)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.north_east,
                        size: 18,
                        color: Palette.of(context).muted,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ],
  );
  Widget contact(BuildContext context) => split(
    context,
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Eyebrow('06 / ${t(Copy.contact)}'),
        const SizedBox(height: 18),
        Text(
          t(StudioCopy.contactTitle),
          style: Theme.of(context).textTheme.displayLarge!
              .copyWith(fontSize: 54),
        ),
        const SizedBox(height: 22),
        Text(t(Copy.contactBody), style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 24),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            if (ContactLinks.emailAddress.isNotEmpty)
              TextButton(
                onPressed: () => openLink(
                  Uri(scheme: 'mailto', path: ContactLinks.emailAddress),
                ),
                child: Text(t(StudioCopy.emailLink)),
              ),
            TextButton.icon(
              onPressed: () => openLink(Uri.parse(ContactLinks.linkedin)),
              icon: const Icon(Icons.arrow_outward, size: 16),
              label: Text(t(Copy.linkedin)),
            ),
            TextButton(
              onPressed: () => openLink(Uri.parse(ContactLinks.github)),
              child: Text(t(Copy.github)),
            ),
            TextButton(
              onPressed: () => openLink(Uri.parse(ContactLinks.facebook)),
              child: Text(t(Copy.facebook)),
            ),
          ],
        ),
      ],
    ),
    Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Palette.of(context).panel,
        border: Border.all(color: Palette.of(context).border),
        borderRadius: BorderRadius.circular(Brand.radius),
      ),
      child: ContactForm(
        arabic: arabic,
        onPrepare: (draft) => ContactService.prepare(
          draft,
          destination: Uri.parse(ContactLinks.linkedin),
          openLink: openLink,
        ),
      ),
    ),
  );
}
