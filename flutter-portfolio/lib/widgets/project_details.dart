import 'package:flutter/material.dart';

import '../content/portfolio_content.dart';
import '../design/theme.dart';
import 'project_gallery.dart';
import 'brand_widgets.dart';

void showProjectDialog(
  BuildContext context, {
  required Project project,
  required bool arabic,
  required Future<void> Function(String) open,
}) => showDialog<void>(
  context: context,
  builder: (context) => Dialog(
    insetPadding: const EdgeInsets.all(20),
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 900),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(24, 16, 12, 12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    project.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                IconButton(
                  tooltip: Copy.close.inLanguage(arabic),
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Flexible(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (project.images.isNotEmpty) ...[
                      ProjectGallery(project: project, arabic: arabic),
                      const SizedBox(height: 28),
                    ],
                    Eyebrow(project.category.inLanguage(arabic)),
                    const SizedBox(height: 16),
                    Text(
                      Copy.product.inLanguage(arabic),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    Text(project.description.inLanguage(arabic)),
                    const SizedBox(height: 24),
                    Text(
                      Copy.contribution.inLanguage(arabic),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    Text(project.contribution.inLanguage(arabic)),
                    const SizedBox(height: 24),
                    Text(
                      Copy.features.inLanguage(arabic),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    ...project.features.map(
                      (f) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              size: 19,
                              color: Palette.of(context).accent,
                            ),
                            const SizedBox(width: 10),
                            Expanded(child: Text(f.inLanguage(arabic))),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(Copy.projectNote.inLanguage(arabic)),
                    const SizedBox(height: 24),
                    if (project.url.isNotEmpty)
                      FilledButton.icon(
                        onPressed: () => open(project.url),
                        icon: const Icon(Icons.open_in_new, size: 18),
                        label: Text(
                          (project.code ? Copy.source : Copy.store).inLanguage(
                            arabic,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  ),
);
