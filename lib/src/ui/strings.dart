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
  late final String floatingPanels;
  late final String headersShadow;
  late final String panelsDecorImage;
  late final String success;
  late final String error;
  late final String invalidData;
  late final String recordSuccessMessage;
  late final String recordErrorMessage;
  late final String editCancelQuestion;
  late final String editDeleteQuestion;
  late final String deleteSuccessMessage;
  late final String deleteErrorMessage;
  late final String noData;
  late final String noDataFound;
  late final String theme;

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
        required Map<String, String> no,
        required Map<String, String> floatingPanels,
        required Map<String, String> headersShadow,
        required Map<String, String> panelsDecorImage,
        required Map<String, String> success,
        required Map<String, String> error,
        required Map<String, String> invalidData,
        required Map<String, String> recordSuccessMessage,
        required Map<String, String> recordErrorMessage,
        required Map<String, String> editCancelQuestion,
        required Map<String, String> editDeleteQuestion,
        required Map<String, String> deleteSuccessMessage,
        required Map<String, String> deleteErrorMessage,
        required Map<String, String> noData,
        required Map<String, String> noDataFound,
        required Map<String, String> theme
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
    this.floatingPanels = parse(floatingPanels);
    this.headersShadow = parse(headersShadow);
    this.panelsDecorImage = parse(panelsDecorImage);
    this.success = parse(success);
    this.error = parse(error);
    this.invalidData = parse(invalidData);
    this.recordSuccessMessage = parse(recordSuccessMessage);
    this.recordErrorMessage = parse(recordErrorMessage);
    this.editCancelQuestion = parse(editCancelQuestion);
    this.editDeleteQuestion = parse(editDeleteQuestion);
    this.deleteSuccessMessage = parse(deleteSuccessMessage);
    this.deleteErrorMessage = parse(deleteErrorMessage);
    this.noData = parse(noData);
    this.noDataFound = parse(noDataFound);
    this.theme = parse(theme);
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