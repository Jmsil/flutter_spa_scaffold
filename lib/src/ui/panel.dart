import 'package:flutter/material.dart';
import 'package:spa_scaffold/src/ui/window.dart';

class SpaPanel extends Container {
  SpaPanel({
    double? width,
    double? height,
    required Color color,
    BoxShadow? shadow,
    EdgeInsets? margins,
    EdgeInsets? paddings = SpaWindow.allPaddings,
    BorderRadius? borders,
    String? backgroundAsset,
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
        image: backgroundAsset == null
          ? null
          : DecorationImage(
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter,
              image: AssetImage('assets/images/$backgroundAsset')
            ),
        borderRadius: borders,
        boxShadow: shadow != null ? [shadow] : null
      ),
      clipBehavior: borders == null || paddings != null ? Clip.none : Clip.antiAlias,
      child: child
    );
}