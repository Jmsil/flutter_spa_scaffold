import 'package:flutter/material.dart';
import 'package:spa_scaffold/src/ui/strings.dart';
import 'package:spa_scaffold/src/ui/window.dart';

abstract class SpaPage extends StatelessWidget {
  final IconData icon;

  SpaPage(this.icon);

  @override @mustCallSuper
  Widget build(BuildContext context) {
    return Padding(
      padding: SpaWin.edgeInsets16,
      child: contentBuilder(context)
    );
  }

  @protected
  Widget contentBuilder(BuildContext context);

  String getTitle(SpaStrings strings);

  Function()? getOverflowMenuAction(BuildContext context) => null;

  void resetOverflowMenuAction() {}
}