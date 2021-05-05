import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:spa_scaffold/src/ui/theme.dart';

class SpaRadio extends Radio<int> {
  SpaRadio(int value, int groupValue, SpaRadioTheme theme, Function(int)? onChanged)
    :
    super(
      value: value,
      groupValue: groupValue,
      hoverColor: theme.hoverColor,
      focusColor: theme.hoverColor,
      fillColor: MaterialStateProperty.resolveWith<Color>(theme.getColor),
      mouseCursor: SystemMouseCursors.basic,
      onChanged: onChanged != null ? (value) => onChanged(value!) : null
    );
}