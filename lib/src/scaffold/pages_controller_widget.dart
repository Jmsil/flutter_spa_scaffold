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
import 'package:spa_scaffold/src/ui/tab_control.dart';
import 'package:spa_scaffold/src/ui/text.dart';
import 'package:spa_scaffold/src/ui/window.dart';

class PagesControllerWidget extends StatelessWidget {
  static final EdgeInsets _appbarMargins = SpaWin.parsePaddings(-1, -1, -1, 0);
  static final EdgeInsets _pagesTabPaddings = EdgeInsets.fromLTRB(32, 0, 32, 0);

  final GlobalKey<DrawerControllerState> _mainMenuKey;

  PagesControllerWidget(this._mainMenuKey);

  @override
  Widget build(BuildContext context) {
    final SpaSettingsModel mSets = context.watch<SpaSettingsModel>();
    final PagesControllerModel mController = context.watch<PagesControllerModel>();
    final List<SpaPage> controllerPages = mController.pages;
    final SpaText appName =
      _getHeaderTitle(mSets.strings.appName, mSets.theme.headerTheme.titleStyle);

    final List<Widget> appbarChildren = [
      SpaIconButton(
        Icons.menu, mSets.theme.headerTheme.iconButtonTheme,
        () => _mainMenuKey.currentState?.open()
      )
    ];

    if (mController.hasOpenPages) {
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
                      child: mController.isHome
                        ? appName
                        : _getHeaderTitle(
                            mController.currentPage.getTitle(mSets.strings),
                            mSets.theme.headerTheme.titleStyle
                          )
                    ),
                    SpaSep.sep8,
                    SpaIconButton(
                      Icons.segment, mSets.theme.headerTheme.iconButtonTheme,
                      () => _showOpenPages(context)
                    )
                  ]
                );
              }

              double maxPageCellWidth = 0;
              final List<Widget> pagesTabChildren = [
                Icon(
                  Icons.home,
                  color: mSets.theme.headerTheme.tabbarTheme.getIconColor(
                    mController.isActive(0)
                  )
                )
              ];

              for (int i = 1; i < controllerPages.length; i++) {
                SpaText title = SpaText(
                  controllerPages[i].getTitle(mSets.strings),
                  mSets.theme.headerTheme.tabbarTheme.getTextStyle(mController.isActive(i))
                );
                maxPageCellWidth = max(
                  maxPageCellWidth, title.textWidth + SpaTabControl.itemPaddings.horizontal
                );
                pagesTabChildren.add(title);
              }

              Widget bar = SpaTabControl(
                mController.pageIdx,
                mSets.theme.headerTheme.tabbarTheme, _pagesTabPaddings,
                mController.setActivePage, pagesTabChildren
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

    Function()? overflowMenuAction = mController.currentPage.getOverflowMenuAction(context);
    if (overflowMenuAction != null) {
      appbarChildren.add(
        SpaIconButton(
          Icons.adaptive.more, mSets.theme.headerTheme.iconButtonTheme, overflowMenuAction
        )
      );
    }

    appbarChildren.add(
      SpaIconButton(
        Icons.close, mSets.theme.iconButtonXHeaderTheme,
        mController.isHome ? null : mController.closeActivePage
      )
    );

    return Column(
      verticalDirection: VerticalDirection.up,
      children: [
        Expanded(
          child: IndexedStack(
            index: mController.pageIdx,
            children: controllerPages
          )
        ),
        SpaPanel(
          color: mSets.theme.headerTheme.color,
          shadow: mSets.hasHeadersShadow || mSets.isFloatingPanels
            ? mSets.theme.allShadows : null,
          margins: mSets.isFloatingPanels ? _appbarMargins : null,
          borders: mSets.isFloatingPanels ? SpaWin.allBorders : null,
          child: Row(children: appbarChildren)
        )
      ]
    );
  }

  void _showOpenPages(BuildContext context) {
    context.read<MainMenuModel>().setOpenPages();
    _mainMenuKey.currentState?.open();
  }

  SpaText _getHeaderTitle(String text, TextStyle textStyle) =>
    SpaText('   $text', textStyle);
}