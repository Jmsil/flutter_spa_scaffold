import 'package:flutter/material.dart';
import 'package:spa_scaffold/spa_scaffold.dart';

class HomePage extends SpaPage {
  HomePage() : super(Icons.home, '');

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends SpaPageState {
  @override
  Widget contentBuilder(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(48) - SpaPageState.contentPaddings,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 340, maxHeight: 340),
          child: Image.asset('assets/images/app_logo.png')
        )
      )
    );
  }
}