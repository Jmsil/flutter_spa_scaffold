import 'package:flutter/cupertino.dart';
import 'package:spa_scaffold/src/ui/theme.dart';
import 'package:spa_scaffold/src/ui/window.dart';

class SpaTabControl extends CupertinoSegmentedControl<int> {
  static final EdgeInsets itemPaddings = SpaWin.parsePaddings(-1, 4, -1, 4);

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
      children: <Widget>[
        for (Widget child in children)
          Padding(padding: itemPaddings, child: child)
      ].asMap()
    );
}