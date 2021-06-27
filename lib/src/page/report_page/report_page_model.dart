import 'package:flutter/foundation.dart';

abstract class ReportPageModel with ChangeNotifier {
  int _tab = 0;
  bool _hasData = false;

  int get tab => _tab;

  bool get hasData => _hasData;

  void setTab(int idx) {
    if (idx != _tab) {
      _tab = idx;
      notifyListeners();
    }
  }

  void setHasData(bool value) {
    _tab = 1;
    _hasData = value;
    notifyListeners();
  }
}