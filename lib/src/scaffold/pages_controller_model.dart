import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:spa_scaffold/src/page/page.dart';
import 'package:spa_scaffold/src/scaffold/main_menu_item.dart';

class PagesControllerModel with ChangeNotifier {
  int _pageIdx = 0;
  final List<SpaPage> _pages = [];

  PagesControllerModel(SpaPage homePage) {
    _pages.add(homePage);
  }


  int get currentIdx => _pageIdx;

  UnmodifiableListView<SpaPage> get pages => UnmodifiableListView(_pages);

  int get pagesCount => _pages.length;

  bool get isHome => _pageIdx == 0;

  SpaPage get currentPage => _pages[_pageIdx];

  bool get hasOpenPages => _pages.length > 1;


  bool isActive(int idx) => idx == _pageIdx;

  void setActivePage(int idx) {
    if (idx != _pageIdx) {
      _pages[_pageIdx].resetOverflowMenuAction();
      _pageIdx = idx;
      notifyListeners();
    }
  }

  void closeActivePage() {
    _pages.removeAt(_pageIdx);

    if (_pageIdx == _pages.length)
      _pageIdx--;

    notifyListeners();
  }

  // TODO: Open pages asynchronously.
  void openPageFromMainMenu(SpaMainMenuAction action) {
    int newIdx = -1;
    for (int i = 0; i < _pages.length; i++) {
      if (_pages[i].runtimeType == action.pageType) {
        newIdx = i;
        break;
      }
    }

    //for (int i = 1; i <= 20; i++)
    //if (newIdx == -1) {
      _pages.add(action.builder(action.icon));
      newIdx = _pages.length - 1;
    //}

    setActivePage(newIdx);
  }
}