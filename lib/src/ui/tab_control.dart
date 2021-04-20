import 'package:flutter/cupertino.dart';
import 'package:spa_scaffold/src/ui/theme.dart';

class SpaTabControl extends CupertinoSegmentedControl<int> {
  SpaTabControl(
    int tab, SpaTabbarTheme theme, EdgeInsets? paddings, Function(int) callback,
    List<Widget> children
  )
    :
    super(
      groupValue: tab,
      onValueChanged: callback,
      selectedColor: theme.selectedColor,
      unselectedColor: theme.unselectedColor,
      pressedColor: theme.pressedColor,
      borderColor: theme.borderColor,
      padding: paddings,
      children: children.asMap()
    );
}