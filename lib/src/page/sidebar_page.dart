import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';
import 'package:spa_scaffold/src/page/page.dart';
import 'package:spa_scaffold/src/page/settings_model.dart';
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

abstract class SpaSidebarPageState<T extends SpaSidebarPage> extends SpaPageState<T> {
  @protected
  static final SpaSeparator defaultSeparator = SpaSeparator(0.5);
  static final EdgeInsets _fixedBarMargins = SpaWindow.parseMargins(-1, -1, 0, -1);

  @override @nonVirtual
  Widget build(BuildContext context) {
    final SpaTheme theme = context.read<SpaTheme>();
    final bool isFloatingPanel =
      context.select<SpaSettingsModel, bool>((sets) => sets.isFloatingPanel);
    final bool hasPanelBackground =
      context.select<SpaSettingsModel, bool>((sets) => sets.hasPanelBackground);
    final bool isLargeScreen = context.isLargeScreen;

    Widget bar = SpaPanel(
      width: 170,
      color: theme.barTheme.color,
      shadow: isFloatingPanel || ! isLargeScreen ? theme.allShadows : null,
      margins: isFloatingPanel
        ? isLargeScreen ? _fixedBarMargins : SpaWindow.allMargins
        : null,
      paddings: null,
      borders: isFloatingPanel ? SpaWindow.allBorders : null,
      backgroundAsset: hasPanelBackground ? theme.sidebarPageBackgroundAsset : null,
      child: SpaListView(sidebarBuilder(context))
    );

    if (isLargeScreen) {
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
  void performAction(Function() action) {
    if (widget._menuKey.currentState == null)
      action();
    else {
      widget.resetOverflowMenuAction();
      Timer(Duration(milliseconds: SpaWindow.drawerClosingWait), action);
    }
  }
}