import 'package:flutter/material.dart';
import 'package:spa_scaffold/src/ui/window.dart';

// TODO: Try to imporove shadow performance.
class SpaPanel extends Container {
  SpaPanel({
    double? width,
    double? height,
    required Color color,
    BoxShadow? shadow,
    EdgeInsets? margins,
    EdgeInsets? paddings = SpaWindow.allPaddings,
    BorderRadius? borders,
    required Widget child
  })
    :
    super(
      width: width,
      height: height,
      margin: margins,
      padding: paddings,
      decoration: BoxDecoration(
        color:  color,
        borderRadius: borders,
        boxShadow: shadow != null ? [shadow] : null
      ),
      child: child
    );
}