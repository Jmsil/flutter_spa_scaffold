import 'package:flutter/material.dart';
import 'package:spa_scaffold/src/ui/separator.dart';

class SpaListView extends StatelessWidget {
  final List<Widget> children;

  SpaListView(this.children);

  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController(keepScrollOffset: false);

    return Scrollbar(
      //key: GlobalKey(),
      //isAlwaysShown: true,
      controller: controller,
      thickness: 4,
      child: ListView(
        controller: controller,
        children: [
          ...children,
          SpaSep.sep32
        ]
      )
    );
  }
}