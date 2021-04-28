import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:spa_scaffold/src/ui/theme.dart';

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