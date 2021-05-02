import 'package:flutter/material.dart';

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
  static const EdgeInsets contentPaddings = EdgeInsets.all(16);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: contentPaddings,
      child: contentBuilder(context)
    );
  }

  @protected
  Widget contentBuilder(BuildContext context);
}