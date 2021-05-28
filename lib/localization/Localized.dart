import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// AppLocalizations
class Localized {
  final Locale locale;

  Localized(this.locale);

  static Localized of(BuildContext context) {
    return Localizations.of<Localized>(context, Localized);
  }

  static const LocalizationsDelegate<Localized> delegate = _LocalizedDelegate();
  Map<String, String> _localizedStrings;

  Future<bool> load() async {
    // Load language JSON
    String jsonString = await rootBundle.loadString('i18n/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    return true;
  }

  // Get localized string
  String trans(String key) {
    return _localizedStrings[key];
  }

}

class _LocalizedDelegate extends LocalizationsDelegate<Localized> {
  const _LocalizedDelegate();

  @override 
  bool isSupported(Locale locale) {
    return ['en'].contains(locale.languageCode);
  }

  @override
  Future<Localized> load(Locale locale) async {
    Localized localization = new Localized(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(_LocalizedDelegate old) {
    return false;
  }
}