import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa_scaffold/src/page/page.dart';
import 'package:spa_scaffold/src/page/settings_page.dart' deferred as sets_page;
import 'package:spa_scaffold/src/scaffold/main_menu_item.dart';
import 'package:spa_scaffold/src/scaffold/main_menu_model.dart';
import 'package:spa_scaffold/src/scaffold/pages_controller_model.dart';
import 'package:spa_scaffold/src/settings.dart';
import 'package:spa_scaffold/src/ui/button.dart';
import 'package:spa_scaffold/src/ui/list_view.dart';
import 'package:spa_scaffold/src/ui/panel.dart';
import 'package:spa_scaffold/src/ui/separator.dart';
import 'package:spa_scaffold/src/ui/strings.dart';
import 'package:spa_scaffold/src/ui/text.dart';
import 'package:spa_scaffold/src/ui/theme.dart';
import 'package:spa_scaffold/src/ui/window.dart';

class MainMenuWidget extends StatelessWidget {
  static final EdgeInsets _menuMargins = EdgeInsets.all(18);
  static final EdgeInsets _headerPaddings = SpaWindow.parsePaddings(-1, 16, -1, -1);
  static final EdgeInsets _tallHeaderPaddings = SpaWindow.parsePaddings(-1, 36, -1, -1);

  final GlobalKey<DrawerControllerState> _drawerKey;

  MainMenuWidget(this._drawerKey);

  @override
  Widget build(BuildContext context) {
    final SpaTheme theme = context.read<SpaTheme>();
    final SpaStrings strings = context.read<SpaStrings>();
    final SpaSettings settings = context.watch<SpaSettings>();
    final PagesControllerModel controllerModel = context.read<PagesControllerModel>();
    final MainMenuModel menuModel = context.watch<MainMenuModel>();
    final bool controllerModelHasOpenPages =
      context.select<PagesControllerModel, bool>((model) => model.hasOpenPages);
    final bool isTallScreen = context.isTallScreen;

    final List<Widget> menuChildren = [];
    final SpaMainMenuGroup? currentMenu = menuModel.currentMenu;

    if (currentMenu != null) {
      _insertSpacer(menuChildren, theme.menuItemTheme, settings);

      for (SpaMainMenuItem item in currentMenu.items) {
        menuChildren.add(
          SpaMenuItem(
            item.icon, item.text,
            item is SpaMainMenuGroup ? Icons.keyboard_arrow_right : null,
            theme.menuItemTheme,
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
          ? theme.menuItemSelectedPageTheme
          : theme.menuItemUnselectedPageTheme;

        if (i == 0) {
          _insertSpacer(menuChildren, itemTheme, settings);
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

    final BoxShadow? headerShadow = settings.headersHasShadow
      ? currentMenu != null
        ? theme.mainMenuHeaderShadow
        : controllerModel.isHome
          ? theme.pagesMenuHeaderFirstSelectedShadow
          : theme.pagesMenuHeaderFirstUnselectedShadow
      : null;

    // TODO: Adapt menu's width dynamically.
    return DrawerController(
      key: _drawerKey,
      alignment: DrawerAlignment.start,
      scrimColor: theme.navigatorBackgroundColor,
      drawerCallback: (isOpened) => _drawerCallback(isOpened, menuModel),
      child: SpaPanel(
        width: 250,
        color: theme.contentPanelTheme.color,
        shadow: theme.allShadows,
        margins: settings.floatingPanels ? _menuMargins : null,
        borders: settings.floatingPanels ? SpaWindow.allBorders : null,
        paddings: null,
        child: Column(
          verticalDirection: VerticalDirection.up,
          children: [

            // Menu
            Expanded(child: SpaListView(menuChildren)),

            // Header
            SpaPanel(
              color: theme.headerPanelTheme.color,
              shadow: headerShadow,
              paddings: isTallScreen ? _tallHeaderPaddings : _headerPaddings,
              child: Column(
                children: [
                  Row(
                    children: [
                      SpaSeparator(),
                      GestureDetector(
                        onTap: () => _openSettingsPage(controllerModel, strings),
                        child: CircleAvatar(
                          child: SpaText('J', TextStyle(fontSize: 20, color: Colors.blue[100]))
                        )
                      ),
                      SpaSeparator(),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SpaText(strings.loggedUser, theme.headerPanelTheme.titleStyle),
                            SpaText('jmsilva.inbox', theme.headerPanelTheme.subtitleStyle)
                          ]
                        )
                      ),
                      SpaSeparator(),
                      SpaIconButton(Icons.logout, theme.headerPanelTheme.iconButtonTheme, () {})
                    ]
                  ),
                  SpaSeparator(isTallScreen ? 3 : 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SpaIconButton(
                        Icons.arrow_back, theme.headerPanelTheme.iconButtonTheme,
                        menuModel.isRoot ? null : menuModel.back
                      ),

                      if (currentMenu != null)
                        SpaIconButton(
                          Icons.home, theme.headerPanelTheme.iconButtonTheme,
                          menuModel.isRoot ? null : menuModel.reset
                        ),

                      if (currentMenu == null)
                        SpaText(strings.openPages, theme.headerPanelTheme.subtitleStyle),

                      SpaIconButton(
                        Icons.segment, theme.headerPanelTheme.iconButtonTheme,
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

  void _insertSpacer(List<Widget> children, SpaMenuItemTheme theme, SpaSettings settings) {
    if (settings.headersHasShadow)
      children.add(Container(height: 4, color: theme.getSurfaceColor(true)));
  }

  void _openPageFromMainMenu(PagesControllerModel controller, SpaMainMenuAction item) {
    _drawerKey.currentState?.close();
    controller.openPageFromMainMenu(item);
  }

  void _drawerCallback(bool isOpened, MainMenuModel model) {
    if (! isOpened)
      Timer(Duration(milliseconds: SpaWindow.drawerClosingWait), model.reset);
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