import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ViewsController extends ChangeNotifier {
  int currentView = 0;

  void changeView(int index) {
    currentView = index;
    notifyListeners();
  }

  final ItemScrollController itemScrollController = ItemScrollController();

}
