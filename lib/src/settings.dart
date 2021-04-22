import 'package:flutter/foundation.dart';

class SpaSettings with ChangeNotifier {
  bool _floatingPanels;
  bool _headersHasShadow;

  SpaSettings(this._floatingPanels, this._headersHasShadow);


  bool get floatingPanels => _floatingPanels;

  set floatingPanels(bool value) {
    if (value != _floatingPanels) {
      _floatingPanels = value;
      notifyListeners();
    }
  }


  bool get headersHasShadow => _headersHasShadow;

  set headersHasShadow(bool value) {
    if (value != _headersHasShadow) {
      _headersHasShadow = value;
      notifyListeners();
    }
  }
}