import 'package:flutter/foundation.dart';

class SpaSettings with ChangeNotifier {
  bool _floatingPanels;

  bool get floatingPanels => _floatingPanels;

  set floatingPanels(bool value) {
    if (value != _floatingPanels) {
      _floatingPanels = value;
      notifyListeners();
    }
  }


  bool _mainMenuHeaderHasShadow;

  bool get mainMenuHeaderHasShadow => _mainMenuHeaderHasShadow;

  set mainMenuHeaderHasShadow(bool value) {
    if (value != _mainMenuHeaderHasShadow) {
      _mainMenuHeaderHasShadow = value;
      notifyListeners();
    }
  }

  SpaSettings(this._floatingPanels, this._mainMenuHeaderHasShadow);
}