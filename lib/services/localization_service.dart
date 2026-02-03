import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  static const String _localeKey = 'app_locale';
  Locale _locale = const Locale('en');
  Map<String, String> _localizedStrings = {};
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  Future<void> initialize() async {
    if (_isInitialized) return;
    await _loadLocale();
    _isInitialized = true;
    notifyListeners();
  }

  LocaleProvider() {
    // We will call initialize() explicitly in main()
  }

  Locale get locale => _locale;
  bool get isAr => _locale.languageCode == 'ar';

  Future<void> toggleLocale() async {
    final newCode = isAr ? 'en' : 'ar';
    await setLocale(Locale(newCode));
  }

  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    await _loadTranslations();
    await _saveLocale();
    notifyListeners();
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_localeKey) ?? 'en';
    _locale = Locale(code);
    await _loadTranslations();
    notifyListeners();
  }

  Future<void> _loadTranslations() async {
    final jsonString = await rootBundle.loadString(
      'assets/lang/${_locale.languageCode}.json',
    );
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map(
      (key, value) => MapEntry(key, value.toString()),
    );
  }

  Future<void> _saveLocale() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, _locale.languageCode);
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }
}

extension LocalizationExtension on BuildContext {
  String tr(String key) {
    return Provider.of<LocaleProvider>(this, listen: false).translate(key);
  }
}
