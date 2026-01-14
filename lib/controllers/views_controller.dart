import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ViewsController extends ChangeNotifier {
  int currentView = 0;
  Map<int, double> _sectionVisibility = {}; // Track visibility of each section

  void changeView(int index) {
    if (currentView != index) {
      currentView = index;
      notifyListeners();
    }
  }

  void updateSectionVisibility(int index, double visibility) {
    _sectionVisibility[index] = visibility;
    
    // Find the section with the highest visibility
    if (_sectionVisibility.isNotEmpty) {
      final maxEntry = _sectionVisibility.entries.reduce(
        (a, b) => a.value > b.value ? a : b,
      );
      
      // Only update if a section has significant visibility (>= 60%)
      if (maxEntry.value >= 60 && currentView != maxEntry.key) {
        changeView(maxEntry.key);
      }
    }
  }

  final ItemScrollController itemScrollController = ItemScrollController();

}
