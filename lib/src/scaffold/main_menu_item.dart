import 'package:flutter/widgets.dart';
import 'package:spa_scaffold/src/page/page.dart';

abstract class SpaMainMenuItem {
  final IconData icon;
  final String text;
  SpaMainMenuItem(this.icon, this.text);
}

class SpaMainMenuGroup extends SpaMainMenuItem {
  final List<SpaMainMenuItem> items = [];
  SpaMainMenuGroup(IconData icon, String text) : super(icon, text);
}

class SpaMainMenuAction<T extends SpaPage> extends SpaMainMenuItem {
  final T Function(IconData icon) builder;
  SpaMainMenuAction(IconData icon, String text, this.builder) : super(icon, text);
  Type get pageType => T;
}