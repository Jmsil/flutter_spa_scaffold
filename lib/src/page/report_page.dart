import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';
import 'package:spa_scaffold/src/page/sidebar_page.dart';
import 'package:spa_scaffold/src/ui/button.dart';
import 'package:spa_scaffold/src/ui/dialogs.dart';
import 'package:spa_scaffold/src/ui/panel.dart';
import 'package:spa_scaffold/src/ui/strings.dart';
import 'package:spa_scaffold/src/ui/tab_control.dart';
import 'package:spa_scaffold/src/ui/theme.dart';

abstract class SpaReportPage extends SpaSidebarPage {
  SpaReportPage(IconData icon, String title) : super(icon, title);

  @override
  SpaReportPageState createState();
}

abstract class SpaReportPageState<T extends SpaReportPage> extends SpaSidebarPageState<T> {
  static final EdgeInsets _tabControlPaddings = EdgeInsets.all(12);

  int _tab = 0;
  bool _hasData = false;

  @override
  List<Widget> sidebarBuilder(BuildContext context) {
    final SpaTheme theme = context.read<SpaTheme>();
    final SpaStrings strings = context.read<SpaStrings>();

    return [
      SpaPanel(
        color: theme.headerTheme.color,
        paddings: null,
        child: SpaTabControl(
          _tab, theme.headerTheme.tabbarTheme, _tabControlPaddings,
          (value) => getBarAction(() => setState(() => _tab = value))(),
          [
            Icon(
              Icons.filter_alt,
              color: theme.headerTheme.tabbarTheme.getIconColor(_tab == 0)
            ),
            Icon(
              Icons.article,
              color: theme.headerTheme.tabbarTheme.getIconColor(_tab == 1)
            )
          ]
        )
      ),
      SpaTextButton(
        Icons.settings, strings.process, theme.barTheme.textButtonTheme,
        getBarAction(_process)
      ),
      SpaSidebarPageState.defaultSeparator,
      SpaTextButton(
        Icons.print, strings.print, theme.barTheme.textButtonTheme,
        getBarAction(_print)
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
    final SpaStrings strings = context.read<SpaStrings>();
    _hasData = await onProcess();
    setState(() {
      _tab = 1;
      if (! _hasData)
        SpaDialogs.showMessage(context, strings.noData, strings.noDataFound);
    });
  }

  void _print() {
    final SpaStrings strings = context.read<SpaStrings>();
    if (! _hasData) {
      SpaDialogs.showMessage(context, strings.noData, strings.noDataFound);
      return;
    }

    onPrint();
  }
}