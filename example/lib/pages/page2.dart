import 'package:example/ui/strings.dart';
import 'package:flutter/material.dart';
import 'package:spa_scaffold/spa_scaffold.dart';

class Page2 extends SpaReportPage {
  Page2(IconData icon) : super(icon);

  @override
  _Page2State createState() => _Page2State();

  @override
  String getTitle(SpaStrings strings) => (strings as AppStrings).pageTitle2;
}

class _Page2State extends SpaReportPageState {
  @override
  Widget filtersBuilder(BuildContext context) => Center();

  @override
  Widget reportBuilder(BuildContext context) => Center();

  @override
  Future<bool> onProcess() async => false;

  @override
  void onPrint() {}
}