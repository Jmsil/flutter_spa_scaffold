import 'package:flutter/material.dart';
import 'package:spa_scaffold/src/ui/separator.dart';

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
        child: child
      )
    );
  }
}

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
        children: [
          ...children,
          SpaSep.sep16
        ]
      )
    );
  }
}

class SpaScrollbar extends RawScrollbar {
  SpaScrollbar(Color color, ScrollController controller, Widget child)
    :
    super(
      thickness: 4,
      thumbColor: color,
      controller: controller,
      child: child
    );
}

class SpaScrollBehavior extends ScrollBehavior {
  static const _physics = BouncingScrollPhysics();

  @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) => child;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) => _physics;
}