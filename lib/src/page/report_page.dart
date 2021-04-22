import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';
import 'package:spa_scaffold/src/page/sidebar_page.dart';
import 'package:spa_scaffold/src/ui/button.dart';
import 'package:spa_scaffold/src/ui/panel.dart';
import 'package:spa_scaffold/src/ui/strings.dart';
import 'package:spa_scaffold/src/ui/tab_control.dart';
import 'package:spa_scaffold/src/ui/theme.dart';
import 'package:spa_scaffold/src/ui/window.dart';

abstract class SpaReportPage extends SpaSidebarPage {
  SpaReportPage(IconData icon, String title) : super(icon, title);

  @override
  SpaReportPageState createState();
}

abstract class SpaReportPageState<T extends SpaReportPage> extends SpaSidebarPageState<T> {
  static final EdgeInsets _tabControlPaddings = SpaWindow.parsePaddings(-1, 12, -1, -1);

  int _tab = 0;
  bool _hasData = false;

  @override @nonVirtual
  List<Widget> sidebarBuilder(BuildContext context) {
    final SpaTheme theme = context.read<SpaTheme>();
    final SpaStrings strings = context.read<SpaStrings>();

    return [
      SpaPanel(
        color: theme.headerPanelTheme.color,
        paddings: null,
        child: SpaTabControl(
          _tab, theme.headerPanelTheme.tabbarTheme, _tabControlPaddings,
          (value) => performAction(() => setState(() => _tab = value)),
          [
            Icon(
              Icons.filter_alt,
              color: theme.headerPanelTheme.tabbarTheme.getIconColor(_tab == 0)
            ),
            Icon(
              Icons.article,
              color: theme.headerPanelTheme.tabbarTheme.getIconColor(_tab == 1)
            )
          ]
        )
      ),
      SpaTextButton(
        Icons.settings, strings.process, theme.barPanelTheme.textButtonTheme,
        () => performAction(_process)
      ),
      SpaSidebarPageState.defaultSeparator,
      SpaTextButton(
        Icons.print, strings.print, theme.barPanelTheme.textButtonTheme,
        () => performAction(_print)
      )
    ];
  }

  @override @nonVirtual
  Widget contentBuilder(BuildContext context) {
    return IndexedStack(
      index: _tab,
      children: [
        filtersBuilder(context),
        reportBuilder(context)
      ]
    );
  }

  @protected
  Widget filtersBuilder(BuildContext context);

  @protected
  Widget reportBuilder(BuildContext context);

  @protected
  Future<bool> onProcess();

  @protected
  void onPrint();

  void _process() async {
    _hasData = await onProcess();
    setState(() {
      _tab = 1;
      if (! _hasData) {
        // Show no data found message here.
      }
    });
  }

  void _print() {
    if (! _hasData) {
      // Show no data found message here.
      return;
    }

    onPrint();
  }
}