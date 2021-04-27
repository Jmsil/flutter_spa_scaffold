import 'package:flutter/foundation.dart';

class SpaSettingsModel with ChangeNotifier {
  bool _isFloatingPanel;
  bool _hasHeaderShadow;
  bool _hasPanelBackground;

  SpaSettingsModel(this._isFloatingPanel, this._hasHeaderShadow, this._hasPanelBackground);


  bool get isFloatingPanel => _isFloatingPanel;

  set isFloatingPanel(bool value) {
    if (value != _isFloatingPanel) {
      _isFloatingPanel = value;
      notifyListeners();
    }
  }


  bool get hasHeaderShadow => _hasHeaderShadow;

  set hasHeaderShadow(bool value) {
    if (value != _hasHeaderShadow) {
      _hasHeaderShadow = value;
      notifyListeners();
    }
  }


  bool get hasPanelBackground => _hasPanelBackground;

  set hasPanelBackground(bool value) {
    if (value != _hasPanelBackground) {
      _hasPanelBackground = value;
      notifyListeners();
    }
  }
}