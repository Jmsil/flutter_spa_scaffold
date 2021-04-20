import 'package:flutter/material.dart';
import 'package:spa_scaffold/spa_scaffold.dart';

class Page2 extends SpaReportPage {
  Page2(IconData icon, String title) : super(icon, title);

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends SpaReportPageState {
  @override
  Widget filtersBuilder(BuildContext context) {
    return Center();
  }

  @override
  Widget reportBuilder(BuildContext context) {
    return Center();
  }

  @override
  Future<bool> onProcess() async {
    return false;
  }

  @override
  void onPrint() {}
}