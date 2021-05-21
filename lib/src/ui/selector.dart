import 'package:flutter/material.dart';
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

class SpaSwitch extends Switch {
  SpaSwitch(bool value, SpaSwitchTheme theme, Function(bool)? onChanged)
  :
    super(
      value: value,
      activeColor: theme.activeColor,
      activeTrackColor: theme.activeTrackColor,
      inactiveThumbColor: theme.inactiveThumbColor,
      inactiveTrackColor: theme.inactiveTrackColor,
      focusColor: theme.hoverColor,
      hoverColor: theme.hoverColor,
      mouseCursor: SystemMouseCursors.basic,
      onChanged: onChanged
    );
}