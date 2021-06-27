import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';
import 'package:spa_scaffold/src/page/page.dart';
import 'package:spa_scaffold/src/page/settings_page/settings_model.dart';
import 'package:spa_scaffold/src/ui/drawer_controller.dart';
import 'package:spa_scaffold/src/ui/panel.dart';
import 'package:spa_scaffold/src/ui/scroll_view.dart';
import 'package:spa_scaffold/src/ui/window.dart';

abstract class SpaMenuPage<T extends ChangeNotifier> extends SpaPage<T> {
  static final EdgeInsets _fixedMenuMargins = SpaWin.parseMargins(-1, -1, 0, -1);

  final GlobalKey<DrawerControllerState> _menuKey = GlobalKey();

  SpaMenuPage(IconData icon, [T? model]) : super(icon, model);

  @override @nonVirtual
  Widget pageBuilder(BuildContext context) {
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
          Expanded(
            child: contentBuilder(context)
          )
        ]
      );
    }

    return Stack(
      children: [
        contentBuilder(context),
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
  Widget contentBuilder(BuildContext context);

  @protected
  List<Widget> menuBuilder(BuildContext context);

  @protected @nonVirtual
  Function() getMenuAction(BuildContext context, Function() action) {
    if (context.screenWidth >= 1024)
      return action;
    return _menuKey.getAction(action);
  }
}