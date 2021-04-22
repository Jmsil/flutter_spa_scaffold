import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';
import 'package:spa_scaffold/src/page/page.dart';
import 'package:spa_scaffold/src/settings.dart';
import 'package:spa_scaffold/src/ui/list_view.dart';
import 'package:spa_scaffold/src/ui/panel.dart';
import 'package:spa_scaffold/src/ui/separator.dart';
import 'package:spa_scaffold/src/ui/theme.dart';
import 'package:spa_scaffold/src/ui/window.dart';

abstract class SpaSidebarPage extends SpaPage {
  final GlobalKey<DrawerControllerState> _menuKey = GlobalKey();

  SpaSidebarPage(IconData icon, String title) : super(icon, title);

  @override
  SpaSidebarPageState createState();

  @override @nonVirtual
  Function()? get overflowMenuAction => () => _menuKey.currentState?.open();

  @override @nonVirtual
  void resetOverflowMenuAction() => _menuKey.currentState?.close();
}

abstract class SpaSidebarPageState<T extends SpaSidebarPage> extends State<T> {
  @protected
  static final SpaSeparator defaultSeparator = SpaSeparator(0.5);

  static final EdgeInsets _fixedMenuMargins = SpaWindow.parseMargins(-1, 0, 0, -1);
  static final EdgeInsets _drawerMenuMargins = SpaWindow.parseMargins(0, 0, -1, -1);
  static final BorderRadius _fixedMenuBorders = SpaWindow.parseBorders(-1, 0, -1, 0);
  static final BorderRadius _drawerMenuBorders = SpaWindow.parseBorders(0, -1, 0, -1);
  static final EdgeInsets _contentMargins = SpaWindow.parseMargins(-1, 0, -1, -1);
  static final BorderRadius _contentWithMenuBorders = SpaWindow.parseBorders(0, -1, 0, -1);

  @override
  Widget build(BuildContext context) {
    final SpaTheme theme = context.read<SpaTheme>();
    final bool floatingPanels = context.select<SpaSettings, bool>((sets) => sets.floatingPanels);
    final bool isLargeScreen = context.isLargeScreen;

    Widget menu = SpaPanel(
      width: 170,
      color: theme.barPanelTheme.color,
      shadow: floatingPanels || ! isLargeScreen ? theme.allShadows : null,
      margins: floatingPanels
        ? isLargeScreen ? _fixedMenuMargins : _drawerMenuMargins
        : null,
      borders: floatingPanels
        ? isLargeScreen ? _fixedMenuBorders : _drawerMenuBorders
        : null,
      paddings: null,
      child: SpaListView(sidebarBuilder(context))
    );

    Widget content = SpaPanel(
      color: theme.contentPanelTheme.color,
      shadow: floatingPanels ? theme.allShadows : null,
      margins: floatingPanels ? _contentMargins : null,
      borders: floatingPanels
        ? isLargeScreen ? _contentWithMenuBorders : SpaWindow.allBorders
        : null,
      child: contentBuilder(context)
    );

    if (isLargeScreen) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          menu,
          Expanded(child: content)
        ]
      );
    }

    return Stack(
      children: [
        content,
        DrawerController(
          key: widget._menuKey,
          alignment: DrawerAlignment.end,
          scrimColor: Colors.transparent,
          child: menu
        )
      ]
    );
  }

  @protected
  List<Widget> sidebarBuilder(BuildContext context);

  @protected
  Widget contentBuilder(BuildContext context);

  @protected @nonVirtual
  void performAction(Function() action) async {
    if (widget._menuKey.currentState == null)
      action();
    else {
      widget.resetOverflowMenuAction();
      Timer(Duration(milliseconds: SpaWindow.drawerClosingWait), action);
    }
  }
}