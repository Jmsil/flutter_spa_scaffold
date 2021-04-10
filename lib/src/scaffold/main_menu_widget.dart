import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa_scaffold/src/page/page.dart';
import 'package:spa_scaffold/src/page/settings_page.dart';
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
  static final EdgeInsets _menuPaddings = SpaWindow.parsePaddings(0, 0, 0, -1);
  static final EdgeInsets _headerPaddings = SpaWindow.parsePaddings(-1, 16, -1, -1);
  static final EdgeInsets _tallHeaderPaddings = SpaWindow.parsePaddings(-1, 36, -1, -1);
  static final BorderRadius _headerBorders = SpaWindow.parseBorders(-1, -1, 0, 0);

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
    final List<SpaMainMenuItem>? currentMenu = menuModel.currentMenu;

    if (currentMenu != null) {
      for (SpaMainMenuItem item in currentMenu) {
        menuChildren.add(
          SpaMenuItem(
            item.icon, item.text,
            item is SpaMainMenuGroup ? Icons.keyboard_arrow_right : null,
            theme.menuItemTheme,
            item is SpaMainMenuGroup
              ? () => menuModel.openGroup(item)
              : () => _openPageFromMainMenu(context, controllerModel, item as SpaMainMenuAction)
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
          menuChildren.add(
            SpaMenuItem.icon(
              pages[i].icon, itemTheme, () => _setActivePage(context, i, controllerModel)
            )
          );
        }
        else {
          menuChildren.add(
            SpaMenuItem(
              pages[i].icon, pages[i].title, null, itemTheme,
              () => _setActivePage(context, i, controllerModel)
            )
          );
        }
      }
    }

    if (settings.mainMenuHeaderHasShadow)
      menuChildren.insert(0, Container(height: 3, color: (menuChildren[0] as SpaMenuItem).color));

    // TODO: Adapt menu's width dynamically.
    return DrawerController(
      key: _drawerKey,
      alignment: DrawerAlignment.start,
      scrimColor: Color(0x4D000000),
      drawerCallback: (isOpened) => _drawerCallback(isOpened, menuModel),
      child: SpaPanel(
        width: 250,
        color: theme.menuPanelColor,
        shadow: theme.allShadows,
        margins: settings.floatingPanels ? _menuMargins : null,
        borders: settings.floatingPanels ? SpaWindow.allBorders : null,
        paddings: _menuPaddings,
        child: Column(
          verticalDirection: VerticalDirection.up,
          children: [

            // Menu
            Expanded(child: SpaListView(menuChildren)),

            // Header
            SpaPanel(
              color: theme.headerPanelColor,
              shadow: settings.mainMenuHeaderHasShadow
                ? currentMenu != null
                  ? theme.mainMenuHeaderShadow
                  : controllerModel.isHome
                    ? theme.pagesMenuHeaderFirstSelectedShadow
                    : theme.pagesMenuHeaderFirstUnselectedShadow
                : null,
              paddings: isTallScreen ? _tallHeaderPaddings : _headerPaddings,
              borders: settings.floatingPanels ? _headerBorders : null,
              child: Column(
                children: [
                  Row(
                    children: [
                      SpaSeparator(),
                      GestureDetector(
                        onTap: () => _openSettingsPage(context, controllerModel, strings),
                        child: CircleAvatar(
                          child: SpaText('J', TextStyle(fontSize: 20, color: Colors.blue[100]))
                        )
                      ),
                      SpaSeparator(),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SpaText('Usuário Logado', theme.headerTitleStyle),
                            SpaText('jmsilva.inbox', theme.headerSubtitleStyle)
                          ]
                        )
                      ),
                      SpaSeparator(),
                      SpaIconButton(Icons.logout, theme.iconButtonHeaderTheme, () {})
                    ]
                  ),
                  SpaSeparator(isTallScreen ? 3 : 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SpaIconButton(
                        Icons.arrow_back, theme.iconButtonHeaderTheme,
                        menuModel.isRoot ? null : menuModel.back
                      ),

                      if (currentMenu != null)
                        SpaIconButton(
                          Icons.home, theme.iconButtonHeaderTheme,
                          menuModel.isRoot ? null : menuModel.reset
                        ),

                      if (currentMenu == null)
                        SpaText(strings.openPages, theme.headerSubtitleStyle),

                      SpaIconButton(
                        Icons.segment,
                        theme.iconButtonHeaderTheme,
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

  void _openPageFromMainMenu(
      BuildContext context, PagesControllerModel controller, SpaMainMenuAction item
    )
  {
    controller.openPageFromMainMenu(item);
    Navigator.of(context).pop();
  }

  void _drawerCallback(bool isOpened, MainMenuModel model) {
    if (! isOpened)
      model.reset();
  }

  void _setActivePage(BuildContext context, int idx, PagesControllerModel model) {
    model.setActivePage(idx);
    Navigator.of(context).pop();
  }

  void _openSettingsPage(
      BuildContext context, PagesControllerModel controller, SpaStrings strings
    )
  {
    controller.openPageFromMainMenu(
      SpaMainMenuAction<SettingsPage>(
        Icons.settings, '',
        (icon) => SettingsPage(icon, strings.userPreferences)
      )
    );
    Navigator.of(context).pop();
  }
}