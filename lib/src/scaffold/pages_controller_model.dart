import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:spa_scaffold/src/page/page.dart';
import 'package:spa_scaffold/src/scaffold/main_menu_item.dart';
import 'package:spa_scaffold/src/ui/window.dart';

class PagesControllerModel with ChangeNotifier {
  bool _isOpeningPage = false;
  int _pageIdx = 0;
  final List<SpaPage> _pages;

  PagesControllerModel(SpaPage homePage) : _pages = [homePage];


  int get pageIdx => _pageIdx;

  UnmodifiableListView<SpaPage> get pages => UnmodifiableListView(_pages);

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

  void openPageFromMainMenu(SpaMainMenuAction action) {
    if (_isOpeningPage)
      return;

    _isOpeningPage = true;

    Timer(
      Duration(milliseconds: SpaWindow.drawerClosingWait),
      () async {
        int newIdx = -1;
        for (int i = 0; i < _pages.length; i++) {
          if (action.isPageType(_pages[i].runtimeType)) {
            newIdx = i;
            break;
          }
        }

        if (newIdx == -1) {
          _pages.add(await action.buildPage());
          newIdx = _pages.length - 1;
        }

        setActivePage(newIdx);
        _isOpeningPage = false;
      }
    );
  }
}