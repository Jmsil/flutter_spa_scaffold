import 'dart:ui';

import 'package:meta/meta.dart';

class SpaStrings {
  final String _lang;
  final String _langScript;
  final String _langCountry;
  final String _fullCode;

  late final String appName;
  late final String openPages;
  late final String loggedUser;
  late final String userPreferences;
  late final String process;
  late final String print;
  late final String record;
  late final String cancel;
  late final String delete;
  late final String ok;
  late final String yes;
  late final String no;

  SpaStrings(
      Locale locale,
      {
        required Map<String, String> appName,
        required Map<String, String> activePages,
        required Map<String, String> loggedUser,
        required Map<String, String> userPreferences,
        required Map<String, String> process,
        required Map<String, String> print,
        required Map<String, String> record,
        required Map<String, String> cancel,
        required Map<String, String> delete,
        required Map<String, String> ok,
        required Map<String, String> yes,
        required Map<String, String> no
      }
    )
    :
    _lang = locale.languageCode,
    _langScript = '${locale.languageCode}_${locale.scriptCode}',
    _langCountry = '${locale.languageCode}_${locale.countryCode}',
    _fullCode = '${locale.languageCode}_${locale.scriptCode}_${locale.countryCode}'
  {
    this.appName = parse(appName);
    this.openPages = parse(activePages);
    this.loggedUser = parse(loggedUser);
    this.userPreferences = parse(userPreferences);
    this.process = parse(process);
    this.print = parse(print);
    this.record = parse(record);
    this.cancel = parse(cancel);
    this.delete = parse(delete);
    this.ok = parse(ok);
    this.yes = parse(yes);
    this.no = parse(no);
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