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
  static final EdgeInsets _appbarMargins = SpaWin.parsePaddings(-1, -1, -1, 0);
  static final EdgeInsets _pagesTabPaddings = EdgeInsets.fromLTRB(32, 0, 32, 0);

  final GlobalKey<DrawerControllerState> _mainMenuKey;

  PagesControllerWidget(this._mainMenuKey);

  @override
  Widget build(BuildContext context) {
    final SpaStrings strings = context.read<SpaStrings>();
    final SpaSettingsModel sets = context.watch<SpaSettingsModel>();
    final PagesControllerModel controllerModel = context.watch<PagesControllerModel>();

    final List<SpaPage> controllerPages = controllerModel.pages;
    final SpaText appName = _getHeaderTitle(strings.appName, sets.theme);

    final List<Widget> appbarChildren = [
      SpaIconButton(
        Icons.menu, sets.theme.headerTheme.iconButtonTheme,
        () => _mainMenuKey.currentState?.open()
      )
    ];

    if (controllerModel.hasOpenPages) {
      appbarChildren.add(
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (
                  (constraints.maxWidth - _pagesTabPaddings.horizontal)
                  / controllerPages.length < 56
                )
              {
                return Row(
                  children: [
                    Expanded(
                      child: controllerModel.isHome
                        ? appName
                        : _getHeaderTitle(controllerModel.currentPage.title, sets.theme)
                    ),
                    SpaSep.sep8,
                    SpaIconButton(
                      Icons.segment, sets.theme.headerTheme.iconButtonTheme,
                      () => _showOpenPages(context)
                    )
                  ]
                );
              }

              double maxPageCellWidth = 0;
              final List<Widget> pagesTabChildren = [
                Icon(
                  Icons.home,
                  color: sets.theme.headerTheme.tabbarTheme.getIconColor(
                    controllerModel.isActive(0)
                  )
                )
              ];

              for (int i = 1; i < controllerPages.length; i++) {
                SpaText title = SpaText(
                  controllerPages[i].title,
                  sets.theme.headerTheme.tabbarTheme.getTextStyle(controllerModel.isActive(i))
                );
                maxPageCellWidth = max(
                  maxPageCellWidth, title.textWidth + SpaWin.horPaddings.horizontal
                );
                pagesTabChildren.add(Padding(padding: SpaWin.horPaddings, child: title));
              }

              Widget bar = SpaTabControl(
                controllerModel.pageIdx,
                sets.theme.headerTheme.tabbarTheme, _pagesTabPaddings,
                controllerModel.setActivePage, pagesTabChildren
              );

              if (
                (constraints.maxWidth - min(appName.textWidth, 80) - _pagesTabPaddings.horizontal)
                / controllerPages.length < maxPageCellWidth
              )
                return bar;

              return Row(
                children: [
                  Expanded(child: appName),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: constraints.maxWidth - appName.textWidth
                    ),
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
      appbarChildren.add(SpaSep.sep8);
    }

    Function()? overflowMenuAction = controllerModel.currentPage.getOverflowMenuAction(context);
    if (overflowMenuAction != null) {
      appbarChildren.add(
        SpaIconButton(
          Icons.adaptive.more, sets.theme.headerTheme.iconButtonTheme, overflowMenuAction
        )
      );
    }

    appbarChildren.add(
      SpaIconButton(
        Icons.close, sets.theme.iconButtonXHeaderTheme,
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
          color: sets.theme.headerTheme.color,
          shadow: sets.hasHeadersShadow || sets.isFloatingPanels
            ? sets.theme.allShadows : null,
          margins: sets.isFloatingPanels ? _appbarMargins : null,
          borders: sets.isFloatingPanels ? SpaWin.allBorders : null,
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