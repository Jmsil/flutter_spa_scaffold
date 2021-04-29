import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa_scaffold/src/page/page.dart';
import 'package:spa_scaffold/src/page/settings_model.dart';
import 'package:spa_scaffold/src/scaffold/main_menu_model.dart';
import 'package:spa_scaffold/src/scaffold/pages_controller_model.dart';
import 'package:spa_scaffold/src/ui/button.dart';
import 'package:spa_scaffold/src/ui/panel.dart';
import 'package:spa_scaffold/src/ui/separator.dart';
import 'package:spa_scaffold/src/ui/strings.dart';
import 'package:spa_scaffold/src/ui/tab_control.dart';
import 'package:spa_scaffold/src/ui/text.dart';
import 'package:spa_scaffold/src/ui/theme.dart';
import 'package:spa_scaffold/src/ui/window.dart';

class PagesControllerWidget extends StatelessWidget {
  static final EdgeInsets _appbarMargins = SpaWindow.parsePaddings(-1, -1, -1, 0);
  static final EdgeInsets _pagesBarPaddings = EdgeInsets.fromLTRB(32, 0, 32, 0);
  static final EdgeInsets _pagesBarItemPaddings = SpaWindow.parsePaddings(-1, 0, -1, 0);

  final GlobalKey<DrawerControllerState> _mainMenuKey;

  PagesControllerWidget(this._mainMenuKey);

  @override
  Widget build(BuildContext context) {
    final SpaTheme theme = context.read<SpaTheme>();
    final SpaStrings strings = context.read<SpaStrings>();
    final SpaSettingsModel settings = context.watch<SpaSettingsModel>();
    final PagesControllerModel controllerModel = context.watch<PagesControllerModel>();

    final List<SpaPage> controllerPages = controllerModel.pages;
    final SpaText appName = _getHeaderTitle(strings.appName, theme);

    final List<Widget> appbarChildren = [
      SpaIconButton(
        Icons.menu, theme.headerTheme.iconButtonTheme,
        () => _mainMenuKey.currentState?.open()
      )
    ];

    if (controllerModel.hasOpenPages) {
      appbarChildren.add(
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (
                  (constraints.maxWidth - _pagesBarPaddings.horizontal)
                  / controllerModel.pagesCount < 56
                )
              {
                return Row(
                  children: [
                    Expanded(child: controllerModel.isHome
                      ? appName
                      : _getHeaderTitle(controllerModel.currentPage.title, theme)
                    ),
                    SpaSeparator(),
                    SpaIconButton(
                      Icons.segment, theme.headerTheme.iconButtonTheme,
                      () => _showOpenPages(context)
                    )
                  ]
                );
              }

              double maxPageCellWidth = 0;
              final List<Widget> pagesBarChildren = [];

              for (int i = 0; i < controllerPages.length; i++) {
                if (i == 0) {
                  pagesBarChildren.add(Icon(
                    Icons.home,
                    color: theme.headerTheme.tabbarTheme.getIconColor(
                      controllerModel.isActive(i)
                    )
                  ));
                }
                else {
                  SpaText title = SpaText(
                    controllerPages[i].title,
                    theme.headerTheme.tabbarTheme.getTextStyle(controllerModel.isActive(i))
                  );
                  maxPageCellWidth = max(
                    maxPageCellWidth,
                    title.getTextWidth() + _pagesBarItemPaddings.horizontal
                  );
                  pagesBarChildren.add(Padding(padding: _pagesBarItemPaddings, child: title));
                }
              }

              double appNameWidth = appName.getTextWidth();
              Widget bar = SpaTabControl(
                controllerModel.pageIdx, theme.headerTheme.tabbarTheme, _pagesBarPaddings,
                controllerModel.setActivePage, pagesBarChildren
              );

              if (
                (constraints.maxWidth - min(appNameWidth, 120) - _pagesBarPaddings.horizontal)
                / controllerPages.length < maxPageCellWidth
              )
                return bar;

              return Row(
                children: [
                  Expanded(child: appName),
                  ConstrainedBox(
                    constraints: BoxConstraints(minWidth: constraints.maxWidth - appNameWidth),
                    child: bar
                  )
                ]
              );
            }
          )
        )
      );
    }
    else {
      appbarChildren.add(Expanded(child: appName));
      appbarChildren.add(SpaSeparator());
    }

    if (! context.isLargeScreen) {
      appbarChildren.add(
        SpaIconButton(
          Icons.adaptive.more, theme.headerTheme.iconButtonTheme,
          controllerModel.currentPage.overflowMenuAction
        )
      );
    }

    appbarChildren.add(
      SpaIconButton(
        Icons.close, theme.iconButtonXHeaderTheme,
        controllerModel.isHome ? null : controllerModel.closeActivePage
      )
    );

    return Column(
      verticalDirection: VerticalDirection.up,
      children: [
        Expanded(
          child: IndexedStack(
            index: controllerModel.pageIdx,
            children: controllerPages
          )
        ),
        SpaPanel(
          color: theme.headerTheme.color,
          shadow: settings.hasHeadersShadow || settings.isFloatingPanels ? theme.allShadows : null,
          margins: settings.isFloatingPanels ? _appbarMargins : null,
          borders: settings.isFloatingPanels ? SpaWindow.allBorders : null,
          child: Row(children: appbarChildren)
        )
      ]
    );
  }

  void _showOpenPages(BuildContext context) {
    context.read<MainMenuModel>().setOpenPages();
    _mainMenuKey.currentState?.open();
  }

  SpaText _getHeaderTitle(String text, SpaTheme theme) =>
    SpaText('   $text', theme.headerTheme.titleStyle);
}