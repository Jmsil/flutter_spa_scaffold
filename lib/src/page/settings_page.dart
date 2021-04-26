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
            value: settings.floatingPanels,
            onChanged: (value) => settings.floatingPanels = value
          ),
          Switch(
            value: settings.headersHasShadow,
            onChanged: (value) => settings.headersHasShadow = value
          )
        ]
      )
    );
  }
}