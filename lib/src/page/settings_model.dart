import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:spa_scaffold/src/ui/theme.dart';

class SpaSettingsModel with ChangeNotifier {
  bool _isFloatingPanels;
  bool _hasHeadersShadow;
  bool _hasPanelsDecorImage;

  final List<String> _themesList;
  final SpaTheme Function(int) _themeBuilder;
  int _themeIndex;
  SpaTheme _theme;

  SpaSettingsModel(
    this._isFloatingPanels, this._hasHeadersShadow, this._hasPanelsDecorImage,
    this._themesList, this._themeBuilder, this._themeIndex
  )
    : _theme = _themeBuilder(_themeIndex);


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


  UnmodifiableListView get themesList => UnmodifiableListView(_themesList);

  int get themeIndex => _themeIndex;

  SpaTheme get theme => _theme;

  void setTheme(int index) {
    if (index != _themeIndex) {
      _themeIndex = index;
      _theme = _themeBuilder(_themeIndex);
      notifyListeners();
    }
  }
}