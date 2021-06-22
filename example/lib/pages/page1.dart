import 'package:example/ui/strings.dart';
import 'package:flutter/material.dart';
import 'package:spa_scaffold/spa_scaffold.dart';

class Page1 extends SpaRegistrationPage {
  Page1(IconData icon) : super(icon);

  @override
  String getTitle(SpaStrings strings) => (strings as AppStrings).pageTitle1;

  @override
  Widget contentBuilder(BuildContext context) => Center();

  @override
  Future<RegistrationPageActionReturn> onRecord() async =>
    RegistrationPageActionReturn(true, null);

  @override
  void onClear() {}

  @override
  String? onValidate() => null;

  @override
  Future<RegistrationPageActionReturn> onDelete() async =>
    RegistrationPageActionReturn(true, null);
}