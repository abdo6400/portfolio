import 'all_projects.dart';

/// Selected work is independent of the complete project archive.
final featuredProjects =
    <String>['addustour', 'albasheq', 'sadad', 'pack-and-go']
        .map((id) => allProjects.firstWhere((project) => project.id == id))
        .toList(growable: false);
