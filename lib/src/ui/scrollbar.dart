import 'package:flutter/material.dart';

class SpaScrollbar extends StatelessWidget {
  final Color color;
  final Widget child;
  final ScrollController controller;

  SpaScrollbar(this.color, this.controller, this.child);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: MaterialStateProperty.all(color)
        )
      ),
      child: Scrollbar(
        thickness: 4,
        controller: controller,
        child: child
      )
    );
  }
}