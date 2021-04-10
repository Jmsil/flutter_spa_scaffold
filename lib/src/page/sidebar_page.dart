import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa_scaffold/src/page/page.dart';
import 'package:spa_scaffold/src/settings.dart';
import 'package:spa_scaffold/src/ui/list_view.dart';
import 'package:spa_scaffold/src/ui/panel.dart';
import 'package:spa_scaffold/src/ui/theme.dart';
import 'package:spa_scaffold/src/ui/window.dart';

abstract class SpaSidebarPage<T extends SpaSidebarPageState> extends SpaPage<T> {
  SpaSidebarPage(IconData icon, String title) : super(icon, title);

  @override
  Function()? get overflowMenuAction => () => state._menuKey.currentState?.open();

  @override
  void resetOverflowMenuAction() => state.popDrawer();
}

abstract class SpaSidebarPageState extends State {
  static final EdgeInsets _fixedMenuMargins = SpaWindow.parseMargins(-1, 0, 0, -1);
  static final EdgeInsets _drawerMenuMargins = SpaWindow.parseMargins(0, 0, -1, -1);
  static final BorderRadius _fixedMenuBorders = SpaWindow.parseBorders(-1, 0, -1, 0);
  static final BorderRadius _drawerMenuBorders = SpaWindow.parseBorders(0, -1, 0, -1);
  static final EdgeInsets _floatingMenuPaddings = SpaWindow.parsePaddings(0, -1, 0, -1);
  static final EdgeInsets _flatMenuPaddings = SpaWindow.parsePaddings(0, 0, 0, -1);
  static final EdgeInsets _contentMargins = SpaWindow.parseMargins(-1, 0, -1, -1);
  static final BorderRadius _contentWithMenuBorders = SpaWindow.parseBorders(0, -1, 0, -1);


  final GlobalKey<DrawerControllerState> _menuKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final SpaTheme theme = context.read<SpaTheme>();
    final bool floatingPanels = context.select<SpaSettings, bool>((sets) => sets.floatingPanels);
    final bool isLargeScreen = context.isLargeScreen;

    Widget menu = SpaPanel(
      width: 170,
      color: theme.barPanelColor,
      shadow: floatingPanels || ! isLargeScreen ? theme.allShadows : null,
      margins: floatingPanels
        ? isLargeScreen ? _fixedMenuMargins : _drawerMenuMargins
        : null,
      borders: floatingPanels
        ? isLargeScreen ? _fixedMenuBorders : _drawerMenuBorders
        : null,
      paddings: floatingPanels ? _floatingMenuPaddings : _flatMenuPaddings,
      child: SpaListView(sidebarBuilder(context))
    );

    Widget content = SpaPanel(
      color: theme.contentPanelColor,
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
    else {
      return Stack(
        children: [
          content,
          DrawerController(
            key: _menuKey,
            alignment: DrawerAlignment.end,
            scrimColor: Colors.transparent,
            child: menu
          )
        ]
      );
    }
  }

  @protected
  List<Widget> sidebarBuilder(BuildContext context);

  @protected
  Widget contentBuilder(BuildContext context);

  void popDrawer() => _menuKey.currentState?.close();
}