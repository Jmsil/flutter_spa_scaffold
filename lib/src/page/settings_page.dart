import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa_scaffold/src/page/page.dart';
import 'package:spa_scaffold/src/page/settings_model.dart';
import 'package:spa_scaffold/src/ui/switch.dart';
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
    final SpaSettingsModel settings = context.watch<SpaSettingsModel>();

    return Center(
      child: Column(
        children: [
          SpaSwitch(
            settings.isFloatingPanel, theme.contentTheme.switchTheme,
            (value) => settings.isFloatingPanel = value
          ),
          SpaSwitch(
            settings.hasHeaderShadow, theme.contentTheme.switchTheme,
            (value) => settings.hasHeaderShadow = value
          ),
          SpaSwitch(
            settings.hasPanelBackground, theme.contentTheme.switchTheme,
            (value) => settings.hasPanelBackground = value
          )
        ]
      )
    );
  }
}