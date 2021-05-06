import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa_scaffold/src/page/page.dart';
import 'package:spa_scaffold/src/page/settings_model.dart';
import 'package:spa_scaffold/src/page/settings_page.dart' deferred as sets_page;
import 'package:spa_scaffold/src/scaffold/main_menu.dart';
import 'package:spa_scaffold/src/scaffold/main_menu_model.dart';
import 'package:spa_scaffold/src/scaffold/pages_controller_model.dart';
import 'package:spa_scaffold/src/ui/button.dart';
import 'package:spa_scaffold/src/ui/list_view.dart';
import 'package:spa_scaffold/src/ui/panel.dart';
import 'package:spa_scaffold/src/ui/separator.dart';
import 'package:spa_scaffold/src/ui/strings.dart';
import 'package:spa_scaffold/src/ui/text.dart';
import 'package:spa_scaffold/src/ui/theme.dart';
import 'package:spa_scaffold/src/ui/window.dart';

class MainMenuWidget extends StatelessWidget {
  static final EdgeInsets _compactHeaderPaddings = SpaWin.parsePaddings(-1, 16, -1, -1);
  static final EdgeInsets _extendedHeaderPaddings = SpaWin.parsePaddings(-1, 36, -1, -1);

  final GlobalKey<DrawerControllerState> _drawerKey;

  MainMenuWidget(this._drawerKey);

  @override
  Widget build(BuildContext context) {
    final SpaStrings strings = context.read<SpaStrings>();
    final SpaSettingsModel sets = context.watch<SpaSettingsModel>();
    final MainMenuModel menuModel = context.watch<MainMenuModel>();
    final PagesControllerModel controllerModel = context.read<PagesControllerModel>();
    final bool controllerModelHasOpenPages =
      context.select<PagesControllerModel, bool>((model) => model.hasOpenPages);
    final bool isExtendedHeader = context.screenHeight >= 480;

    final List<Widget> menuChildren = [];
    final SpaMainMenuGroup? currentMenu = menuModel.currentMenu;

    if (currentMenu != null) {
      _insertSpacer(menuChildren, sets.theme.menuItemTheme, sets);

      for (SpaMainMenuItem item in currentMenu.items) {
        menuChildren.add(
          SpaMenuItem(
            item.icon, item.text,
            item is SpaMainMenuGroup ? Icons.keyboard_arrow_right : null,
            sets.theme.menuItemTheme,
            item is SpaMainMenuGroup
              ? () => menuModel.openGroup(item)
              : () => _openPageFromMainMenu(controllerModel, item as SpaMainMenuAction)
          )
        );
      }
    }
    else {
      final List<SpaPage> pages = controllerModel.pages;

      for (int i = 0; i < pages.length; i++) {
        SpaMenuItemTheme itemTheme = controllerModel.isActive(i)
          ? sets.theme.menuItemSelectedPageTheme
          : sets.theme.menuItemUnselectedPageTheme;

        if (i == 0) {
          _insertSpacer(menuChildren, itemTheme, sets);
          menuChildren.add(
            SpaMenuItem.icon(pages[i].icon, itemTheme, () => _setActivePage(i, controllerModel))
          );
        }
        else {
          menuChildren.add(
            SpaMenuItem(
              pages[i].icon, pages[i].title, null, itemTheme,
              () => _setActivePage(i, controllerModel)
            )
          );
        }
      }
    }

    final BoxShadow? headerShadow = sets.hasHeadersShadow
      ? currentMenu != null
        ? sets.theme.mainMenuHeaderShadow
        : controllerModel.isHome
          ? sets.theme.pagesMenuHeaderFirstSelectedShadow
          : sets.theme.pagesMenuHeaderFirstUnselectedShadow
      : null;

    return DrawerController(
      key: _drawerKey,
      alignment: DrawerAlignment.start,
      scrimColor: sets.theme.navigatorBackgroundColor,
      drawerCallback: (isOpened) => _drawerCallback(isOpened, menuModel),
      child: SpaPanel(
        width: 250,
        color: sets.theme.contentTheme.color,
        shadow: sets.theme.allShadows,
        margins: sets.isFloatingPanels ? SpaWin.edgeInsets18 : null,
        borders: sets.isFloatingPanels ? SpaWin.allBorders : null,
        paddings: null,
        clip: sets.isFloatingPanels || sets.hasHeadersShadow,
        backgroundAsset: sets.hasPanelsDecorImage ? sets.theme.mainMenuBackgroundAsset : null,
        child: Column(
          verticalDirection: VerticalDirection.up,
          children: [

            // Menu
            Expanded(child: SpaListView(menuChildren)),

            // Header
            SpaPanel(
              color: sets.theme.headerTheme.color,
              shadow: headerShadow,
              paddings: isExtendedHeader ? _extendedHeaderPaddings : _compactHeaderPaddings,
              child: Column(
                children: [

                  // Logged user session
                  Row(
                    children: [
                      SpaSep.sep8,
                      GestureDetector(
                        onTap: () => _openSettingsPage(controllerModel, strings),
                        child: CircleAvatar(
                          child: SpaText('J', TextStyle(fontSize: 20, color: Colors.blue[100]))
                        )
                      ),
                      SpaSep.sep8,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SpaText(strings.loggedUser, sets.theme.headerTheme.titleStyle),
                            SpaSep.sep2,
                            SpaText('jmsilva.inbox', sets.theme.headerTheme.subtitleStyle)
                          ]
                        )
                      ),
                      SpaSep.sep8,
                      SpaIconButton(Icons.logout, sets.theme.headerTheme.iconButtonTheme, () {})
                    ]
                  ),
                  isExtendedHeader ? SpaSep.sep24 : SpaSep.sep8,

                  // Navigation buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SpaIconButton(
                        Icons.arrow_back, sets.theme.headerTheme.iconButtonTheme,
                        menuModel.isRoot ? null : menuModel.back
                      ),

                      if (currentMenu != null)
                        SpaIconButton(
                          Icons.home, sets.theme.headerTheme.iconButtonTheme,
                          menuModel.isRoot ? null : menuModel.reset
                        ),

                      if (currentMenu == null)
                        Expanded(
                          child: Padding(
                            padding: SpaWin.horPaddings,
                            child: SpaText(
                              strings.openPages, sets.theme.headerTheme.subtitleStyle,
                              textAlign: TextAlign.center
                            )
                          )
                        ),

                      SpaIconButton(
                        Icons.segment, sets.theme.headerTheme.iconButtonTheme,
                        controllerModelHasOpenPages && currentMenu != null
                          ? () => menuModel.setOpenPages() : null
                      )
                    ]
                  )
                ]
              )
            )
          ]
        )
      )
    );
  }

  void _insertSpacer(List<Widget> children, SpaMenuItemTheme theme, SpaSettingsModel settings) {
    if (settings.hasHeadersShadow)
      children.add(Container(height: 4, color: theme.getSurfaceColor(true)));
  }

  void _openPageFromMainMenu(PagesControllerModel controller, SpaMainMenuAction item) {
    _drawerKey.currentState?.close();
    controller.openPageFromMainMenu(item);
  }

  void _drawerCallback(bool isOpened, MainMenuModel model) {
    if (! isOpened)
      Timer(Duration(milliseconds: SpaWin.drawerClosingWait), model.reset);
  }

  void _setActivePage(int idx, PagesControllerModel model) {
    _drawerKey.currentState?.close();
    model.setActivePage(idx);
  }

  void _openSettingsPage(PagesControllerModel controller, SpaStrings strings) {
    _openPageFromMainMenu(
      controller,
      SpaMainMenuAction(
        Icons.settings, '',
        sets_page.loadLibrary,
        (icon) => sets_page.SettingsPage(icon, strings.userPreferences)
      )
    );
  }
}