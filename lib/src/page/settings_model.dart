import 'package:flutter/foundation.dart';

class SpaSettingsModel with ChangeNotifier {
  bool _isFloatingPanels;
  bool _hasHeadersShadow;
  bool _hasPanelsDecorImage;

  SpaSettingsModel(this._isFloatingPanels, this._hasHeadersShadow, this._hasPanelsDecorImage);


  bool get isFloatingPanels => _isFloatingPanels;

  set isFloatingPanels(bool value) {
    if (value != _isFloatingPanels) {
      _isFloatingPanels = value;
      notifyListeners();
    }
  }


  bool get hasHeadersShadow => _hasHeadersShadow;

  set hasHeadersShadow(bool value) {
    if (value != _hasHeadersShadow) {
      _hasHeadersShadow = value;
      notifyListeners();
    }
  }


  bool get hasPanelsDecorImage => _hasPanelsDecorImage;

  set hasPanelsDecorImage(bool value) {
    if (value != _hasPanelsDecorImage) {
      _hasPanelsDecorImage = value;
      notifyListeners();
    }
  }
}