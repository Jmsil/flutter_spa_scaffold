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

abstract class SpaReportPage extends SpaMenuPage {
  SpaReportPage(IconData icon) : super(icon);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ReportPageModel>(
      create: (context) => ReportPageModel(),
      builder: (context, child) => super.build(context)
    );
  }

  @override
  Widget contentBuilder(BuildContext context) {
    final ReportPageModel model = context.watch<ReportPageModel>();
    return IndexedStack(
      index: model.tab,
      children: [
        filtersBuilder(context),
        reportBuilder(context)
      ]
    );
  }

  @override
  List<Widget> menuBuilder(BuildContext context) {
    final SpaSettingsModel mSets = context.watch<SpaSettingsModel>();
    final ReportPageModel mReportPage = context.watch<ReportPageModel>();
    return [
      SpaPanel(
        color: mSets.theme.headerTheme.color,
        paddings: null,
        child: SpaTabControl(
          mReportPage.tab, mSets.theme.headerTheme.tabbarTheme, SpaWin.edgeInsets12,
          (value) => getMenuAction(context, () => mReportPage.setTab(value))(),
          [
            Icon(
              Icons.filter_alt_outlined,
              color: mSets.theme.headerTheme.tabbarTheme.getIconColor(mReportPage.tab == 0)
            ),
            Icon(
              Icons.analytics_outlined,
              color: mSets.theme.headerTheme.tabbarTheme.getIconColor(mReportPage.tab == 1)
            )
          ]
        )
      ),
      SpaTextButton(
        Icons.settings_outlined, mSets.strings.process, mSets.theme.barTheme.textButtonTheme,
        getMenuAction(context, () => _process(context, mSets, mReportPage))
      ),
      SpaSep.sep4,
      SpaTextButton(
        Icons.print_outlined, mSets.strings.print, mSets.theme.barTheme.textButtonTheme,
        getMenuAction(context, () => _print(context, mSets, mReportPage))
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

  void _process(
      BuildContext context, SpaSettingsModel mSets, ReportPageModel mReportPage
    ) async
  {
    mReportPage.setHasData(await onProcess());
    if (!mReportPage.hasData)
      SpaDialogs.showMessage(context, mSets.strings.noData, mSets.strings.noDataFound);
  }

  void _print(BuildContext context, SpaSettingsModel mSets, ReportPageModel mReportPage) {
    if (!mReportPage.hasData) {
      SpaDialogs.showMessage(context, mSets.strings.noData, mSets.strings.noDataFound);
      return;
    }
    onPrint();
  }
}