import 'package:flutter/foundation.dart';
import 'package:spa_scaffold/src/scaffold/main_menu_item.dart';

class MainMenuModel with ChangeNotifier {
  final List<SpaMainMenuItem> _root;
  final List<List<SpaMainMenuItem>?> _stack = [];

  MainMenuModel(this._root) {
    _stack.add(_root);
  }

  bool get isRoot => _stack.length == 1;

  List<SpaMainMenuItem>? get currentMenu => _stack.last;


  void openGroup(SpaMainMenuGroup group) {
    _stack.add(group.items);
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