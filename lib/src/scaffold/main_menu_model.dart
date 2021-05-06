import 'package:flutter/foundation.dart';
import 'package:spa_scaffold/src/scaffold/main_menu.dart';

class MainMenuModel with ChangeNotifier {
  final SpaMainMenuGroup _root;
  final List<SpaMainMenuGroup?> _stack = [];

  MainMenuModel(this._root) {
    _stack.add(_root);
  }

  bool get isRoot => _stack.length == 1;

  SpaMainMenuGroup? get currentMenu => _stack.last;


  void openGroup(SpaMainMenuGroup group) {
    _stack.add(group);
    notifyListeners();
  }

  void setOpenPages() {
    _stack.clear();
    _stack.add(_root);
    _stack.add(null);
    notifyListeners();
  }

  void back() {
    _stack.removeLast();
    notifyListeners();
  }

  void reset() {
    if (_stack.length > 1) {
      _stack.clear();
      _stack.add(_root);
      notifyListeners();
    }
  }
}