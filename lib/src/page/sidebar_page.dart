import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';
import 'package:spa_scaffold/src/page/page.dart';
import 'package:spa_scaffold/src/page/settings_model.dart';
import 'package:spa_scaffold/src/ui/list_view.dart';
import 'package:spa_scaffold/src/ui/panel.dart';
import 'package:spa_scaffold/src/ui/window.dart';

abstract class SpaSidebarPage extends SpaPage {
  final GlobalKey<DrawerControllerState> _menuKey = GlobalKey();

  SpaSidebarPage(IconData icon) : super(icon);

  @override
  SpaSidebarPageState createState();

  @override @nonVirtual
  Function()? getOverflowMenuAction(BuildContext context) {
    if (context.screenWidth >= 1024)
      return null;
    return () => _menuKey.currentState?.open();
  }

  @override @nonVirtual
  void resetOverflowMenuAction() => _menuKey.currentState?.close();
}

abstract class SpaSidebarPageState<T extends SpaSidebarPage> extends SpaPageState<T> {
  static final EdgeInsets _fixedBarMargins = SpaWin.parseMargins(-1, -1, 0, -1);

  @override @nonVirtual
  Widget build(BuildContext context) {
    final SpaSettingsModel mSets = context.watch<SpaSettingsModel>();
    final bool isFixedBar = context.screenWidth >= 1024;

    Widget bar = SpaPanel(
      width: 170,
      color: mSets.theme.barTheme.color,
      shadow: mSets.isFloatingPanels || ! isFixedBar ? mSets.theme.allShadows : null,
      margins: mSets.isFloatingPanels
        ? isFixedBar ? _fixedBarMargins : SpaWin.allMargins
        : null,
      paddings: null,
      borders: mSets.isFloatingPanels ? SpaWin.allBorders : null,
      clip: mSets.isFloatingPanels,
      backgroundAsset: mSets.hasPanelsDecorImage ? mSets.theme.sidebarPageBackgroundAsset : null,
      child: SpaListView(mSets.theme.menuScrollbarColor, sidebarBuilder(context))
    );

    if (isFixedBar) {
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
          key: widget._menuKey,
          alignment: DrawerAlignment.end,
          scrimColor: Colors.transparent,
          child: bar
        )
      ]
    );
  }

  @protected
  List<Widget> sidebarBuilder(BuildContext context);

  @protected @nonVirtual
  Function() getBarAction(Function() action) {
    if (context.screenWidth >= 1024)
      return action;

    return () {
      widget.resetOverflowMenuAction();
      Timer(Duration(milliseconds: SpaWin.drawerClosingWait), action);
    };
  }
}