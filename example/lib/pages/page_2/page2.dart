import 'package:example/pages/page_2/page_2_model.dart';
import 'package:example/ui/strings.dart';
import 'package:flutter/material.dart';
import 'package:spa_scaffold/spa_scaffold.dart';

class Page2 extends SpaReportPage {
  Page2(IconData icon) : super(icon, Page2Model());

  @override
  String getTitle(SpaStrings strings) => (strings as AppStrings).pageTitle2;

  @override
  Widget filtersBuilder(BuildContext context) => Center();

  @override
  Widget reportBuilder(BuildContext context) => Center();

  @override
  Future<bool> onProcess() async => false;

  @override
  void onPrint() {}
}