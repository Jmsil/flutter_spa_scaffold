import 'package:flutter/material.dart';
import 'package:spa_scaffold/spa_scaffold.dart';

class HomePage extends SpaPage {
  HomePage() : super(Icons.home, '');

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(90),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 340, maxHeight: 340),
          child: Image.asset('assets/images/app_logo.png')
        )
      )
    );
  }
}