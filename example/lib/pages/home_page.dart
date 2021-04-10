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
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 420, maxHeight: 420),
        child: Image.asset('assets/images/app_logo.jpg')
      )
    );
  }
}