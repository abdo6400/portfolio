import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio/models/cv_model.dart';

class InformationController extends ChangeNotifier {
  CV? cv;
  Future<void> loadInformation() async {
    cv = await loadCV();
    notifyListeners();
  }

  Future<CV> loadCV() async {
    final String response = await rootBundle.loadString('assets/cover.json');
    final data = await json.decode(response);
    return CV.fromJson(data);
  }
}
