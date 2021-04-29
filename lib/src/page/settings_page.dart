import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa_scaffold/src/page/page.dart';
import 'package:spa_scaffold/src/page/settings_model.dart';
import 'package:spa_scaffold/src/ui/strings.dart';
import 'package:spa_scaffold/src/ui/switch.dart';
import 'package:spa_scaffold/src/ui/text.dart';
import 'package:spa_scaffold/src/ui/theme.dart';

class SettingsPage extends SpaPage {
  SettingsPage(IconData icon, String title) : super(icon, title);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends SpaPageState {
  @override
  Widget contentBuilder(BuildContext context) {
    final SpaTheme theme = context.read<SpaTheme>();
    final SpaStrings strings = context.read<SpaStrings>();
    final SpaSettingsModel settings = context.watch<SpaSettingsModel>();

    return Center(
      child: Table(
        defaultColumnWidth: IntrinsicColumnWidth(),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(children: [
            SpaText(strings.floatingPanels, theme.contentTheme.subtitleStyle),
            SpaSwitch(
              settings.isFloatingPanel, theme.contentTheme.switchTheme,
              (value) => settings.isFloatingPanel = value
            )
          ]),
          TableRow(children: [
            SpaText(strings.headersShadow, theme.contentTheme.subtitleStyle),
            SpaSwitch(
              settings.hasHeaderShadow, theme.contentTheme.switchTheme,
              (value) => settings.hasHeaderShadow = value
            )
          ]),
          TableRow(children: [
            SpaText(strings.panelsDecorImage, theme.contentTheme.subtitleStyle),
            SpaSwitch(
              settings.hasPanelBackground, theme.contentTheme.switchTheme,
              (value) => settings.hasPanelBackground = value
            )
          ])
        ]
      )
    );
  }
}