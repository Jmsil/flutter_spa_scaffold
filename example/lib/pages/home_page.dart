import 'package:example/ui/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa_scaffold/spa_scaffold.dart';

class HomePage extends SpaPage {
  HomePage() : super(Icons.home, '');

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends SpaPageState {
  @override
  Widget contentBuilder(BuildContext context) {
    final AppTheme theme = context.watch<AppTheme>();
    return Center(
      child: Padding(
        padding: SpaWin.edgeInsets32,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 340, maxHeight: 340),
          child: Image.asset('assets/images/${theme.appLogoAsset}')
        )
      )
    );
  }
}