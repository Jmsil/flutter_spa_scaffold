import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:spa_scaffold/src/page/page.dart';

abstract class SpaMainMenuItem {
  final IconData icon;
  final String text;
  SpaMainMenuItem(this.icon, this.text);
}

class SpaMainMenuGroup extends SpaMainMenuItem {
  final List<SpaMainMenuItem> _items = [];

  SpaMainMenuGroup(IconData icon, String text) : super(icon, text);

  UnmodifiableListView get items => UnmodifiableListView(_items);

  SpaMainMenuGroup addGroup(SpaMainMenuGroup group) {
    _items.add(group);
    return group;
  }

  void addAction(SpaMainMenuAction action) => _items.add(action);
}

class SpaMainMenuAction extends SpaMainMenuItem {
  final Future Function() _libraryLoader;
  final SpaPage Function(IconData icon) _pageBuilder;

  SpaMainMenuAction(IconData icon, String text, this._libraryLoader, this._pageBuilder)
    : super(icon, text);

  bool isPageType(Type type) => _pageBuilder.runtimeType.toString().endsWith('=> $type');

  Future<SpaPage> buildPage() async {
    await _libraryLoader();
    return _pageBuilder(icon);
  }
}