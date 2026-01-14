import 'package:flutter/material.dart';
import 'package:portfolio/views/information/components/paginated_grid.dart';

class InformationGrid extends StatelessWidget {
  final String contentType; // 'projects' or 'certificates'
  const InformationGrid({super.key, this.contentType = 'projects'});

  @override
  Widget build(BuildContext context) {
    return PaginatedGrid(
      contentType: contentType,
      sectionHeight: 800, // Uniform section height
    );
  }
}
