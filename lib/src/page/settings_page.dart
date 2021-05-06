import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa_scaffold/src/page/page.dart';
import 'package:spa_scaffold/src/page/settings_model.dart';
import 'package:spa_scaffold/src/ui/radio.dart';
import 'package:spa_scaffold/src/ui/separator.dart';
import 'package:spa_scaffold/src/ui/strings.dart';
import 'package:spa_scaffold/src/ui/switch.dart';
import 'package:spa_scaffold/src/ui/text.dart';

class SettingsPage extends SpaPage {
  SettingsPage(IconData icon, String title) : super(icon, title);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends SpaPageState {
  @override
  Widget contentBuilder(BuildContext context) {
    final SpaStrings strings = context.read<SpaStrings>();
    final SpaSettingsModel sets = context.watch<SpaSettingsModel>();

    int radioIdx = 0;

    return Center(
      child: Table(
        defaultColumnWidth: IntrinsicColumnWidth(),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(
            children: [
              SpaText(strings.theme, sets.theme.contentTheme.titleStyle), SpaSep.sep0
            ]
          ),
          TableRow(
            children: [
              SpaSep.sep8, SpaSep.sep0
            ]
          ),

          for (String themeName in sets.themesList)
            TableRow(
              children: [
                SpaText(themeName, sets.theme.contentTheme.subtitleStyle),
                SpaRadio(
                  radioIdx++, sets.themeIndex, sets.theme.contentTheme.radioTheme,
                  sets.setTheme
                )
              ]
            ),

          TableRow(
            children: [
              SpaSep.sep24, SpaSep.sep0
            ]
          ),

          TableRow(
            children: [
              SpaText(strings.floatingPanels, sets.theme.contentTheme.subtitleStyle),
              SpaSwitch(
                sets.isFloatingPanels, sets.theme.contentTheme.switchTheme,
                sets.setIsFloatingPanels
              )
            ]
          ),
          TableRow(
            children: [
              SpaText(strings.headersShadow, sets.theme.contentTheme.subtitleStyle),
              SpaSwitch(
                sets.hasHeadersShadow, sets.theme.contentTheme.switchTheme,
                sets.setHasHeadersShadow
              )
            ]
          ),
          TableRow(
            children: [
              SpaText(strings.panelsDecorImage, sets.theme.contentTheme.subtitleStyle),
              SpaSwitch(
                sets.hasPanelsDecorImage, sets.theme.contentTheme.switchTheme,
                sets.setHasPanelsDecorImage
              )
            ]
          )
        ]
      )
    );
  }
}