import 'package:flutter/material.dart';

class SpaText extends Text {
  SpaText(String text, TextStyle style, [bool allowWrap = false])
    :
    super(
      text,
      style: style,
      textScaleFactor: 1,
      softWrap: allowWrap,
      textDirection: TextDirection.ltr,
      overflow: allowWrap ? TextOverflow.visible : TextOverflow.fade
    );

  double getTextWidth() {
    TextPainter painter = TextPainter(
      text: TextSpan(text: this.data, style: this.style),
      maxLines: this.maxLines,
      textScaleFactor: this.textScaleFactor!,
      textDirection: this.textDirection
    );
    painter.layout();
    return painter.size.width;
  }
}