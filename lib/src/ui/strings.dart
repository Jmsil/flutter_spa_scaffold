import 'dart:ui';

import 'package:meta/meta.dart';

class SpaStrings {
  late final String _lang;
  late final String _langScript;
  late final String _langCountry;
  late final String _fullCode;

  late final String appName;
  late final String openPages;
  late final String userPreferences;

  SpaStrings(
      Locale locale,
      {
        required Map<String, String> appName,
        required Map<String, String> activePages,
        required Map<String, String> userPreferences
      }
    )
  {
    _lang = locale.languageCode;
    _langScript = '${locale.languageCode}_${locale.scriptCode}';
    _langCountry = '${locale.languageCode}_${locale.countryCode}';
    _fullCode = '${locale.languageCode}_${locale.scriptCode}_${locale.countryCode}';

    this.appName = parse(appName);
    this.openPages = parse(activePages);
    this.userPreferences = parse(userPreferences);
  }

  @protected @nonVirtual
  String parse(Map<String, String> strings) {
    return
      strings[_fullCode] ??
      strings[_langCountry] ??
      strings[_langScript] ??
      strings[_lang] ??
      strings[strings.keys.first] ??
      '';
  }
}