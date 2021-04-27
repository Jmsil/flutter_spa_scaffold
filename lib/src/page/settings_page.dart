import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa_scaffold/src/page/page.dart';
import 'package:spa_scaffold/src/page/settings_model.dart';

class SettingsPage extends SpaPage {
  SettingsPage(IconData icon, String title) : super(icon, title);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State {
  @override
  Widget build(BuildContext context) {
    final SpaSettingsModel settings = context.watch<SpaSettingsModel>();

    return Center(
      child: Column(
        children: [
          Switch(
            value: settings.isFloatingPanel,
            onChanged: (value) => settings.isFloatingPanel = value
          ),
          Switch(
            value: settings.hasHeaderShadow,
            onChanged: (value) => settings.hasHeaderShadow = value
          ),
          Switch(
            value: settings.hasPanelBackground,
            onChanged: (value) => settings.hasPanelBackground = value
          )
        ]
      )
    );
  }
}