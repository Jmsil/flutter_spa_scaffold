import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';
import 'package:spa_scaffold/src/page/settings_model.dart';
import 'package:spa_scaffold/src/page/sidebar_page.dart';
import 'package:spa_scaffold/src/ui/button.dart';
import 'package:spa_scaffold/src/ui/dialogs.dart';
import 'package:spa_scaffold/src/ui/panel.dart';
import 'package:spa_scaffold/src/ui/separator.dart';
import 'package:spa_scaffold/src/ui/strings.dart';
import 'package:spa_scaffold/src/ui/tab_control.dart';
import 'package:spa_scaffold/src/ui/window.dart';

abstract class SpaReportPage extends SpaSidebarPage {
  SpaReportPage(IconData icon) : super(icon);

  @override
  SpaReportPageState createState();
}

abstract class SpaReportPageState<T extends SpaReportPage> extends SpaSidebarPageState<T> {
  int _tab = 0;
  bool _hasData = false;

  @override
  List<Widget> sidebarBuilder(BuildContext context) {
    final SpaSettingsModel mSets = context.watch<SpaSettingsModel>();
    return [
      SpaPanel(
        color: mSets.theme.headerTheme.color,
        paddings: null,
        child: SpaTabControl(
          _tab, mSets.theme.headerTheme.tabbarTheme, SpaWin.edgeInsets12,
          (value) => getBarAction(() => setState(() => _tab = value))(),
          [
            Icon(
              Icons.filter_alt,
              color: mSets.theme.headerTheme.tabbarTheme.getIconColor(_tab == 0)
            ),
            Icon(
              Icons.article,
              color: mSets.theme.headerTheme.tabbarTheme.getIconColor(_tab == 1)
            )
          ]
        )
      ),
      SpaTextButton(
        Icons.settings, mSets.strings.process, mSets.theme.barTheme.textButtonTheme,
        getBarAction(_process)
      ),
      SpaSep.sep4,
      SpaTextButton(
        Icons.print, mSets.strings.print, mSets.theme.barTheme.textButtonTheme,
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
    final SpaStrings strings = context.read<SpaSettingsModel>().strings;
    _hasData = await onProcess();
    setState(() {
      _tab = 1;
      if (! _hasData)
        SpaDialogs.showMessage(context, strings.noData, strings.noDataFound);
    });
  }

  void _print() {
    final SpaStrings strings = context.read<SpaSettingsModel>().strings;
    if (! _hasData) {
      SpaDialogs.showMessage(context, strings.noData, strings.noDataFound);
      return;
    }

    onPrint();
  }
}