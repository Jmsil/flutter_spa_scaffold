import 'package:flutter/material.dart';
import 'package:spa_scaffold/src/ui/scrollbar.dart';
import 'package:spa_scaffold/src/ui/separator.dart';

class SpaListView extends StatelessWidget {
  final Color scrollbarColor;
  final List<Widget> children;

  SpaListView(this.scrollbarColor, this.children);

  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController(keepScrollOffset: false);
    return SpaScrollbar(
      scrollbarColor,
      controller,
      ListView(
        controller: controller,
        physics: BouncingScrollPhysics(),
        children: [
          ...children,
          SpaSep.sep32
        ]
      )
    );
  }
}