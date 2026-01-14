import 'package:flutter/material.dart';
import 'package:portfolio/views/information/components/card_info.dart';
import 'package:portfolio/views/information/components/certificate_card.dart';
import 'package:portfolio/controllers/information_controller.dart';
import 'package:portfolio/res/responsive.dart';
import 'package:provider/provider.dart';
import '../../../models/project_model.dart';
import '../../../models/certificate_model.dart';

class PaginatedGrid extends StatefulWidget {
  final String contentType; // 'projects' or 'certificates'
  final double sectionHeight;
  const PaginatedGrid({
    super.key,
    this.contentType = 'projects',
    this.sectionHeight = 800,
  });

  @override
  State<PaginatedGrid> createState() => _PaginatedGridState();
}

class _PaginatedGridState extends State<PaginatedGrid> {
  int _currentPage = 0;
  
  int _getItemsPerPage(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    if (isMobile) {
      return 2; // 2 items per page on mobile
    } else if (isTablet) {
      return 4; // 4 items per page on tablet (2 rows x 2)
    } else {
      return 6; // 6 items per page on desktop (2 rows x 3)
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.contentType == 'certificates') {
      return _buildCertificatesGrid(context);
    } else {
      return _buildProjectsGrid(context);
    }
  }

  Widget _buildProjectsGrid(BuildContext context) {
    final cv = context.watch<InformationController>().cv;
    final projects = cv?.projects ?? [];
    final hasCvProjects = projects.isNotEmpty;
    final projectCount = hasCvProjects ? projects.length : projectList.length;
    final itemsPerPage = _getItemsPerPage(context);
    final totalPages = (projectCount / itemsPerPage).ceil();

    if (totalPages <= 1) {
      // No pagination needed
      return _buildProjectItems(context, 0, projectCount, hasCvProjects);
    }

    final startIndex = _currentPage * itemsPerPage;
    final endIndex = (startIndex + itemsPerPage).clamp(0, projectCount);

    return SizedBox(
      height: widget.sectionHeight,
      child: Column(
        children: [
          Expanded(
            child: _buildProjectItems(
                context, startIndex, endIndex, hasCvProjects),
          ),
          _buildPaginationControls(context, totalPages),
        ],
      ),
    );
  }

  Widget _buildProjectItems(
      BuildContext context, int start, int end, bool useCvData) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    final screenWidth = MediaQuery.sizeOf(context).width;
    
    // Calculate responsive card width
    double cardWidth;
    if (isMobile) {
      cardWidth = screenWidth - 40; // Full width minus padding
    } else if (isTablet) {
      cardWidth = (screenWidth - 80) / 2; // 2 cards per row
    } else {
      cardWidth = 320; // Desktop: fixed width
    }
    
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.sizeOf(context).height * 0.02),
      child: Wrap(
        spacing: isMobile ? 10 : 15,
        runSpacing: isMobile ? 10 : 15,
        alignment: WrapAlignment.center,
        children: List.generate(end - start, (index) {
          final actualIndex = start + index;
          return SizedBox(
            height: isMobile ? 300 : 350,
            width: cardWidth,
            child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: EdgeInsets.symmetric(
                    vertical: isMobile ? 10.0 : 20.0, 
                    horizontal: isMobile ? 0 : 20.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary.withOpacity(0.8),
                        Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.3),
                        offset: const Offset(-2, 0),
                        blurRadius: 15,
                      ),
                      BoxShadow(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.3),
                        offset: const Offset(2, 0),
                        blurRadius: 15,
                      ),
                    ]),
                child: CardInfo(
                  index: actualIndex,
                  useCvData: useCvData,
                )),
          );
        }),
      ),
    );
  }

  Widget _buildCertificatesGrid(BuildContext context) {
    final itemsPerPage = _getItemsPerPage(context);
    final totalPages = (certificateList.length / itemsPerPage).ceil();

    if (totalPages <= 1) {
      return _buildCertificateItems(context, 0, certificateList.length);
    }

    final startIndex = _currentPage * itemsPerPage;
    final endIndex =
        (startIndex + itemsPerPage).clamp(0, certificateList.length);

    return SizedBox(
      height: widget.sectionHeight,
      child: Column(
        children: [
          Expanded(
            child: _buildCertificateItems(context, startIndex, endIndex),
          ),
          _buildPaginationControls(context, totalPages),
        ],
      ),
    );
  }

  Widget _buildCertificateItems(
      BuildContext context, int start, int end) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    final screenWidth = MediaQuery.sizeOf(context).width;
    
    // Calculate responsive card width
    double cardWidth;
    if (isMobile) {
      cardWidth = screenWidth - 40; // Full width minus padding
    } else if (isTablet) {
      cardWidth = (screenWidth - 80) / 2; // 2 cards per row
    } else {
      cardWidth = 320; // Desktop: fixed width
    }
    
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.sizeOf(context).height * 0.02),
      child: Wrap(
        spacing: isMobile ? 10 : 15,
        runSpacing: isMobile ? 10 : 15,
        alignment: WrapAlignment.center,
        children: List.generate(end - start, (index) {
          final actualIndex = start + index;
          return SizedBox(
            height: isMobile ? 250 : 280,
            width: cardWidth,
            child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: EdgeInsets.symmetric(
                    vertical: isMobile ? 10.0 : 20.0, 
                    horizontal: isMobile ? 0 : 20.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.tertiary.withOpacity(0.8),
                        Theme.of(context).colorScheme.primary.withOpacity(0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context)
                            .colorScheme
                            .tertiary
                            .withOpacity(0.3),
                        offset: const Offset(-2, 0),
                        blurRadius: 15,
                      ),
                      BoxShadow(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.3),
                        offset: const Offset(2, 0),
                        blurRadius: 15,
                      ),
                    ]),
                child: CertificateCard(index: actualIndex)),
          );
        }),
      ),
    );
  }

  Widget _buildPaginationControls(BuildContext context, int totalPages) {
    if (totalPages <= 1) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Previous button
          IconButton(
            onPressed: _currentPage > 0
                ? () {
                    setState(() {
                      _currentPage--;
                    });
                  }
                : null,
            icon: Icon(
              Icons.chevron_left,
              color: _currentPage > 0
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
            ),
            style: IconButton.styleFrom(
              backgroundColor: _currentPage > 0
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.05),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Page indicators
          ...List.generate(totalPages, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _currentPage = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentPage == index ? 32 : 12,
                height: 12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: _currentPage == index
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.primary.withOpacity(0.3),
                ),
              ),
            );
          }),
          const SizedBox(width: 10),
          // Next button
          IconButton(
            onPressed: _currentPage < totalPages - 1
                ? () {
                    setState(() {
                      _currentPage++;
                    });
                  }
                : null,
            icon: Icon(
              Icons.chevron_right,
              color: _currentPage < totalPages - 1
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
            ),
            style: IconButton.styleFrom(
              backgroundColor: _currentPage < totalPages - 1
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.05),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
