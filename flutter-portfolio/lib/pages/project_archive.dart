import 'package:flutter/material.dart';

import '../content/all_projects.dart';
import '../content/portfolio_content.dart';
import '../widgets/brand_widgets.dart';

class ProjectArchive extends StatefulWidget {
  const ProjectArchive({
    super.key,
    required this.arabic,
    required this.onProject,
  });
  final bool arabic;
  final ValueChanged<Project> onProject;
  @override
  State<ProjectArchive> createState() => _ProjectArchiveState();
}

class _ProjectArchiveState extends State<ProjectArchive> {
  String query = '';
  @override
  Widget build(BuildContext context) {
    final visible = allProjects
        .where(
          (p) =>
              '${p.name} ${p.category.en} ${p.category.ar} ${p.description.en} ${p.description.ar} ${p.tags.join(' ')}'
                  .toLowerCase()
                  .contains(query.trim().toLowerCase()),
        )
        .toList();
    return Dialog.fullscreen(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '${Copy.allWork.inLanguage(widget.arabic)} (${allProjects.length})',
          ),
          leading: IconButton(
            tooltip: Copy.closeArchive.inLanguage(widget.arabic),
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
          ),
        ),
        body: ContentWidth(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: Copy.search.inLanguage(widget.arabic),
                    border: const OutlineInputBorder(),
                  ),
                  onChanged: (value) => setState(() => query = value),
                ),
              ),
              Expanded(
                child: visible.isEmpty
                    ? Center(
                        child: Text(Copy.noResults.inLanguage(widget.arabic)),
                      )
                    : LayoutBuilder(
                        builder: (_, c) => GridView.builder(
                          itemCount: visible.length,
                          padding: const EdgeInsets.only(bottom: 24),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: c.maxWidth >= 900
                                    ? 3
                                    : c.maxWidth >= 620
                                    ? 2
                                    : 1,
                                mainAxisExtent:
                                    650 *
                                    MediaQuery.textScalerOf(context).scale(1),
                                mainAxisSpacing: 24,
                                crossAxisSpacing: 24,
                              ),
                          itemBuilder: (_, i) => ProjectCard(
                            project: visible[i],
                            arabic: widget.arabic,
                            compact: true,
                            onTap: () => widget.onProject(visible[i]),
                            index: allProjects.indexOf(visible[i]) + 1,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
