import 'package:example/ui/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa_scaffold/spa_scaffold.dart';

class HomePage extends SpaPage {
  HomePage() : super(Icons.home_outlined);

  @override
  String getTitle(SpaStrings strings) => '';

  @override
  Widget pageBuilder(BuildContext context) {
    final AppTheme theme = context.watch<SpaSettingsModel>().appTheme;
    return Center(
      child: Padding(
        padding: SpaWin.edgeInsets48,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 340, maxHeight: 340),
          child: Image.asset('assets/images/${theme.appLogoAsset}')
        )
      )
    );
  }
}