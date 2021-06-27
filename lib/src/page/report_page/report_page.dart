import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';
import 'package:spa_scaffold/src/page/menu_page.dart';
import 'package:spa_scaffold/src/page/report_page/report_page_model.dart';
import 'package:spa_scaffold/src/page/settings_page/settings_model.dart';
import 'package:spa_scaffold/src/ui/button.dart';
import 'package:spa_scaffold/src/ui/dialogs.dart';
import 'package:spa_scaffold/src/ui/panel.dart';
import 'package:spa_scaffold/src/ui/separator.dart';
import 'package:spa_scaffold/src/ui/tab_control.dart';
import 'package:spa_scaffold/src/ui/window.dart';

abstract class SpaReportPage<T extends ReportPageModel> extends SpaMenuPage<T> {
  SpaReportPage(IconData icon, T model) : super(icon, model);

  @override @nonVirtual
  Widget contentBuilder(BuildContext context) {
    return IndexedStack(
      index: model!.tab,
      children: [
        filtersBuilder(context),
        reportBuilder(context)
      ]
    );
  }

  @override
  List<Widget> menuBuilder(BuildContext context) {
    final SpaSettingsModel mSets = context.watch<SpaSettingsModel>();
    return [
      SpaPanel(
        color: mSets.theme.headerTheme.color,
        paddings: null,
        child: SpaTabControl(
          model!.tab, mSets.theme.headerTheme.tabbarTheme, SpaWin.edgeInsets12,
          (value) => getMenuAction(context, () => model!.setTab(value))(),
          [
            Icon(
              Icons.filter_alt_outlined,
              color: mSets.theme.headerTheme.tabbarTheme.getIconColor(model!.tab == 0)
            ),
            Icon(
              Icons.analytics_outlined,
              color: mSets.theme.headerTheme.tabbarTheme.getIconColor(model!.tab == 1)
            )
          ]
        )
      ),
      SpaTextButton(
        Icons.settings_outlined, mSets.strings.process, mSets.theme.barTheme.textButtonTheme,
        getMenuAction(context, () => _process(context, mSets))
      ),
      SpaSep.sep4,
      SpaTextButton(
        Icons.print_outlined, mSets.strings.print, mSets.theme.barTheme.textButtonTheme,
        getMenuAction(context, () => _print(context, mSets))
      )
    ];
  }

  @protected
  Widget filtersBuilder(BuildContext context);

  @protected
  Widget reportBuilder(BuildContext context);

  @protected
  Future<bool> onProcess();

  @protected
  void onPrint();

  void _process(BuildContext context, SpaSettingsModel mSets) async {
    model!.setHasData(await onProcess());
    if (!model!.hasData)
      SpaDialogs.showMessage(context, mSets.strings.noData, mSets.strings.noDataFound);
  }

  void _print(BuildContext context, SpaSettingsModel mSets) {
    if (!model!.hasData) {
      SpaDialogs.showMessage(context, mSets.strings.noData, mSets.strings.noDataFound);
      return;
    }
    onPrint();
  }
}