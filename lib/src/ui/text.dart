import 'package:flutter/material.dart';

class SpaText extends Text {
  late final double textWidth = (
    TextPainter(
      text: TextSpan(text: this.data, style: this.style),
      textAlign: this.textAlign!,
      textDirection: this.textDirection,
      textScaleFactor: this.textScaleFactor!,
      maxLines: this.maxLines
    )
    ..layout()
  ).size.width;

  SpaText(
    String text, TextStyle style,
    {bool allowWrap = false, TextAlign textAlign = TextAlign.left}
  )
    :
    super(
      text,
      style: style,
      textAlign: textAlign,
      textScaleFactor: 1,
      softWrap: allowWrap,
      textDirection: TextDirection.ltr,
      overflow: allowWrap ? TextOverflow.visible : TextOverflow.fade
    );
}