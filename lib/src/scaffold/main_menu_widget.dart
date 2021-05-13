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
    final SpaSettingsModel mSets = context.watch<SpaSettingsModel>();
    final MainMenuModel mMenu = context.watch<MainMenuModel>();
    final PagesControllerModel mController = context.read<PagesControllerModel>();
    final bool mControllerHasOpenPages =
      context.select<PagesControllerModel, bool>((model) => model.hasOpenPages);
    final bool isExtendedHeader = context.screenHeight >= 480;
    final List<Widget> menuChildren = [];
    final SpaMainMenuGroup? currentMenu = mMenu.currentMenu;

    if (currentMenu != null) {
      _insertSpacer(menuChildren, mSets.theme.menuItemTheme, mSets);

      for (SpaMainMenuItem item in currentMenu.items) {
        menuChildren.add(
          SpaMenuItem(
            item.icon, item.text,
            item is SpaMainMenuGroup ? Icons.keyboard_arrow_right : null,
            mSets.theme.menuItemTheme,
            item is SpaMainMenuGroup
              ? () => mMenu.openGroup(item)
              : () => _openPageFromMainMenu(mController, item as SpaMainMenuAction)
          )
        );
      }
    }
    else {
      final List<SpaPage> pages = mController.pages;

      for (int i = 0; i < pages.length; i++) {
        SpaMenuItemTheme itemTheme = mController.isActive(i)
          ? mSets.theme.menuItemSelectedPageTheme
          : mSets.theme.menuItemUnselectedPageTheme;

        if (i == 0) {
          _insertSpacer(menuChildren, itemTheme, mSets);
          menuChildren.add(
            SpaMenuItem.icon(pages[i].icon, itemTheme, () => _setActivePage(i, mController))
          );
        }
        else {
          menuChildren.add(
            SpaMenuItem(
              pages[i].icon, pages[i].getTitle(mSets.strings), null, itemTheme,
              () => _setActivePage(i, mController)
            )
          );
        }
      }
    }

    final BoxShadow? headerShadow = mSets.hasHeadersShadow
      ? currentMenu != null
        ? mSets.theme.mainMenuHeaderShadow
        : mController.isHome
          ? mSets.theme.pagesMenuHeaderFirstSelectedShadow
          : mSets.theme.pagesMenuHeaderFirstUnselectedShadow
      : null;

    return DrawerController(
      key: _drawerKey,
      alignment: DrawerAlignment.start,
      scrimColor: mSets.theme.navigatorBackgroundColor,
      drawerCallback: (isOpened) => _drawerCallback(isOpened, mMenu),
      child: SpaPanel(
        width: 250,
        color: mSets.theme.contentTheme.color,
        shadow: mSets.theme.allShadows,
        margins: mSets.isFloatingPanels ? SpaWin.edgeInsets18 : null,
        borders: mSets.isFloatingPanels ? SpaWin.allBorders : null,
        paddings: null,
        clip: mSets.isFloatingPanels || mSets.hasHeadersShadow,
        backgroundAsset: mSets.hasPanelsDecorImage ? mSets.theme.mainMenuBackgroundAsset : null,
        child: Column(
          verticalDirection: VerticalDirection.up,
          children: [

            // Menu
            Expanded(
              child: SpaListView(mSets.theme.menuScrollbarColor, menuChildren)
            ),

            // Header
            SpaPanel(
              color: mSets.theme.headerTheme.color,
              shadow: headerShadow,
              paddings: isExtendedHeader ? _extendedHeaderPaddings : _compactHeaderPaddings,
              child: Column(
                children: [

                  // Logged user session
                  Row(
                    children: [
                      SpaSep.sep8,
                      GestureDetector(
                        onTap: () => _openSettingsPage(mController, mSets.strings),
                        child: CircleAvatar(
                          child: SpaText('J', TextStyle(fontSize: 20, color: Colors.blue[100]))
                        )
                      ),
                      SpaSep.sep8,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SpaText(mSets.strings.loggedUser, mSets.theme.headerTheme.titleStyle),
                            SpaSep.sep2,
                            SpaText('jmsilva.inbox', mSets.theme.headerTheme.subtitleStyle)
                          ]
                        )
                      ),
                      SpaSep.sep8,
                      SpaIconButton(Icons.logout, mSets.theme.headerTheme.iconButtonTheme, () {})
                    ]
                  ),
                  isExtendedHeader ? SpaSep.sep24 : SpaSep.sep8,

                  // Navigation buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SpaIconButton(
                        Icons.arrow_back, mSets.theme.headerTheme.iconButtonTheme,
                        mMenu.isRoot ? null : mMenu.back
                      ),

                      if (currentMenu != null)
                        SpaIconButton(
                          Icons.home, mSets.theme.headerTheme.iconButtonTheme,
                          mMenu.isRoot ? null : mMenu.reset
                        ),

                      if (currentMenu == null)
                        Expanded(
                          child: Padding(
                            padding: SpaWin.horPaddings,
                            child: SpaText(
                              mSets.strings.openPages, mSets.theme.headerTheme.subtitleStyle,
                              textAlign: TextAlign.center
                            )
                          )
                        ),

                      SpaIconButton(
                        Icons.segment, mSets.theme.headerTheme.iconButtonTheme,
                        mControllerHasOpenPages && currentMenu != null
                          ? () => mMenu.setOpenPages() : null
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

  void _insertSpacer(List<Widget> children, SpaMenuItemTheme theme, SpaSettingsModel mSets) {
    if (mSets.hasHeadersShadow)
      children.add(Container(height: 4, color: theme.getSurfaceColor(true)));
  }

  void _openPageFromMainMenu(PagesControllerModel mController, SpaMainMenuAction item) {
    _drawerKey.currentState?.close();
    mController.openPageFromMainMenu(item);
  }

  void _drawerCallback(bool isOpened, MainMenuModel mMenu) {
    if (! isOpened)
      Timer(Duration(milliseconds: SpaWin.drawerClosingWait), mMenu.reset);
  }

  void _setActivePage(int idx, PagesControllerModel mController) {
    _drawerKey.currentState?.close();
    mController.setActivePage(idx);
  }

  void _openSettingsPage(PagesControllerModel mController, SpaStrings strings) {
    _openPageFromMainMenu(
      mController,
      SpaMainMenuAction(
        Icons.settings, '',
        sets_page.loadLibrary,
        (icon) => sets_page.SettingsPage(icon)
      )
    );
  }
}