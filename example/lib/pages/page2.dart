import 'package:flutter/material.dart';
import 'package:spa_scaffold/spa_scaffold.dart';

class Page2 extends SpaSidebarPage<_Page2State> {
  Page2(IconData icon, String title) : super(icon, title);

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends SpaSidebarPageState {
  @override
  List<Widget> sidebarBuilder(BuildContext context) {
    return [];
  }

  @override
  Widget contentBuilder(BuildContext context) {
    return Center();
  }
}