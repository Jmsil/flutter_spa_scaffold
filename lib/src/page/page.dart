import 'package:flutter/material.dart';
import 'package:spa_scaffold/src/ui/window.dart';

abstract class SpaPage extends StatefulWidget {
  final IconData icon;
  final String title;

  SpaPage(this.icon, this.title);

  @override
  SpaPageState createState();

  Function()? getOverflowMenuAction(BuildContext context) => null;

  void resetOverflowMenuAction() {}
}

abstract class SpaPageState<T extends SpaPage> extends State<T> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: SpaWin.edgeInsets16,
      child: contentBuilder(context)
    );
  }

  @protected
  Widget contentBuilder(BuildContext context);
}