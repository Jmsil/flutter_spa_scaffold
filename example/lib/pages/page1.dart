import 'package:flutter/material.dart';
import 'package:spa_scaffold/spa_scaffold.dart';

class Page1 extends SpaRegistrationPage {
  Page1(IconData icon, String title) : super(icon, title);

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends SpaRegistrationPageState {
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