import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:spa_scaffold/src/ui/strings.dart';
import 'package:spa_scaffold/src/ui/theme.dart';

class SpaSettingsModel with ChangeNotifier {
  final List<String> Function(BuildContext) _themesListBuilder;
  final SpaTheme Function(int) _themeBuilder;
  int _themeIndex;
  SpaTheme _theme;

  final List<String> Function(BuildContext) _languagesListBuilder;
  final SpaStrings Function(int) _languageBuilder;
  int _languageIndex;
  SpaStrings _strings;

  bool _isFloatingPanels;
  bool _hasHeadersShadow;
  bool _hasPanelsDecorImage;

  SpaSettingsModel(
    this._themesListBuilder, this._themeBuilder, this._themeIndex,
    this._languagesListBuilder, this._languageBuilder, this._languageIndex,
    this._isFloatingPanels, this._hasHeadersShadow, this._hasPanelsDecorImage
  )
    :
    _theme = _themeBuilder(_themeIndex),
    _strings = _languageBuilder(_languageIndex);


  UnmodifiableListView getThemesList(BuildContext context) =>
    UnmodifiableListView(_themesListBuilder(context));

  int get themeIndex => _themeIndex;

  SpaTheme get theme => _theme;

  void setTheme(int index) {
    if (index != _themeIndex) {
      _themeIndex = index;
      _theme = _themeBuilder(_themeIndex);
      notifyListeners();
    }
  }


  UnmodifiableListView getLanguagesList(BuildContext context) =>
    UnmodifiableListView(_languagesListBuilder(context));

  int get languageIndex => _languageIndex;

  SpaStrings get strings => _strings;

  void setLanguage(int index) {
    if (index != _languageIndex) {
      _languageIndex = index;
      _strings = _languageBuilder(_languageIndex);
      notifyListeners();
    }
  }


  bool get isFloatingPanels => _isFloatingPanels;

  void setIsFloatingPanels(bool value) {
    if (value != _isFloatingPanels) {
      _isFloatingPanels = value;
      notifyListeners();
    }
  }


  bool get hasHeadersShadow => _hasHeadersShadow;

  void setHasHeadersShadow(bool value) {
    if (value != _hasHeadersShadow) {
      _hasHeadersShadow = value;
      notifyListeners();
    }
  }


  bool get hasPanelsDecorImage => _hasPanelsDecorImage;

  void setHasPanelsDecorImage(bool value) {
    if (value != _hasPanelsDecorImage) {
      _hasPanelsDecorImage = value;
      notifyListeners();
    }
  }
}