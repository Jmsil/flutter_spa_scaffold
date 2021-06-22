import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';
import 'package:spa_scaffold/src/page/page.dart';
import 'package:spa_scaffold/src/page/settings_page/settings_model.dart';
import 'package:spa_scaffold/src/ui/panel.dart';
import 'package:spa_scaffold/src/ui/scroll_view.dart';
import 'package:spa_scaffold/src/ui/window.dart';

abstract class SpaMenuPage extends SpaPage {
  static final EdgeInsets _fixedMenuMargins = SpaWin.parseMargins(-1, -1, 0, -1);

  final GlobalKey<DrawerControllerState> _menuKey = GlobalKey();

  SpaMenuPage(IconData icon) : super(icon);

  @override
  Widget build(BuildContext context) {
    final SpaSettingsModel mSets = context.watch<SpaSettingsModel>();
    final bool isFixedMenu = context.screenWidth >= 1024;

    Widget bar = SpaPanel(
      width: 170,
      color: mSets.theme.barTheme.color,
      shadow: mSets.isFloatingPanels || ! isFixedMenu ? mSets.theme.allShadows : null,
      margins: mSets.isFloatingPanels
        ? isFixedMenu ? _fixedMenuMargins : SpaWin.allMargins
        : null,
      paddings: null,
      borders: mSets.isFloatingPanels ? SpaWin.allBorders : null,
      clip: mSets.isFloatingPanels,
      backgroundAsset: mSets.hasPanelsDecorImage ? mSets.theme.sidebarPageBackgroundAsset : null,
      child: SpaListView(mSets.theme.menuScrollbarColor, menuBuilder(context))
    );

    if (isFixedMenu) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          bar,
          Expanded(child: super.build(context))
        ]
      );
    }

    return Stack(
      children: [
        super.build(context),
        DrawerController(
          key: _menuKey,
          alignment: DrawerAlignment.end,
          scrimColor: Colors.transparent,
          child: bar
        )
      ]
    );
  }

  @override @nonVirtual
  Function()? getOverflowMenuAction(BuildContext context) {
    if (context.screenWidth >= 1024)
      return null;
    return () => _menuKey.currentState?.open();
  }

  @override @nonVirtual
  void resetOverflowMenuAction() => _menuKey.currentState?.close();

  @protected
  List<Widget> menuBuilder(BuildContext context);

  @protected @nonVirtual
  Function() getMenuAction(BuildContext context, Function() action) {
    if (context.screenWidth >= 1024)
      return action;

    return () {
      resetOverflowMenuAction();
      Timer(Duration(milliseconds: SpaWin.drawerClosingWait), action);
    };
  }
}