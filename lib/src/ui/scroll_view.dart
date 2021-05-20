import 'package:flutter/material.dart';
import 'package:spa_scaffold/src/ui/scrollbar.dart';

class SpaScrollView extends StatelessWidget {
  final Color scrollbarColor;
  final Widget child;

  SpaScrollView(this.scrollbarColor, this.child);

  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController(keepScrollOffset: false);
    return SpaScrollbar(
      scrollbarColor,
      controller,
      SingleChildScrollView(
        controller: controller,
        physics: BouncingScrollPhysics(),
        child: child
      )
    );
  }
}