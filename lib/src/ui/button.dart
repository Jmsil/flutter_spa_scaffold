import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:spa_scaffold/src/ui/separator.dart';
import 'package:spa_scaffold/src/ui/text.dart';
import 'package:spa_scaffold/src/ui/theme.dart';
import 'package:spa_scaffold/src/ui/window.dart';

const double _separatorScale = 1.5;
final EdgeInsets _iconTextPaddings = SpaWindow.parsePaddings(-1, -1, 12, -1);
final EdgeInsets _menuItemTrailingPaddings = SpaWindow.parsePaddings(-1, -1, 4, -1);

class SpaIconButton extends _ButtonFrame {
  SpaIconButton(IconData icon, SpaIconButtonTheme theme, Function()? onPressed)
    :
    super(
      theme, SpaWindow.allPaddings, SpaWindow.allBorders, onPressed,
      Icon(icon, color: theme.getIconColor(onPressed != null))
    );
}


class SpaTextButton extends _ButtonFrame {
  SpaTextButton(
    IconData icon, String text, SpaTextButtonTheme theme, Function()? onPressed,
    {bool expanded = true, BorderRadius? borders}
  )
    :
    super(
      theme, _iconTextPaddings, borders, onPressed,
      Row(
        mainAxisAlignment: expanded ? MainAxisAlignment.start : MainAxisAlignment.center,
        children: [
          Icon(icon, color: theme.getIconColor(onPressed != null)),
          SpaSeparator(_separatorScale),

          if (expanded)
            Expanded(
              child: SpaText(text, theme.getTextStyle(onPressed != null))
            ),

          if (! expanded)
            SpaText(text, theme.getTextStyle(onPressed != null))
        ]
      )
    );
}


class SpaMenuItem extends _ButtonFrame {
  SpaMenuItem(
    IconData leadingIcon, String text, IconData? trailingIcon, SpaMenuItemTheme theme,
    Function()? onPressed
  )
    :
    super(
      theme,
      trailingIcon == null ? _iconTextPaddings : _menuItemTrailingPaddings,
      null, onPressed,
      Row(
        children: [
          Icon(leadingIcon, color: theme.getIconColor(onPressed != null)),
          SpaSeparator(_separatorScale),
          Expanded(
            child: SpaText(text, theme.getTextStyle(onPressed != null))
          ),

          if (trailingIcon != null)
            ...[
              SpaSeparator(_separatorScale),
              Icon(trailingIcon, color: theme.getTrailingIconColor(onPressed != null))
            ],
        ]
      )
    );

  SpaMenuItem.icon(IconData icon, SpaMenuItemTheme theme, Function()? onPressed)
    :
    super(
      theme, SpaWindow.allPaddings, null, onPressed,
      Icon(icon, color: theme.getIconColor(onPressed != null))
    );
}


class _ButtonFrame extends Material {
  _ButtonFrame(
    SpaTouchableWidgetTheme theme, EdgeInsets paddings, BorderRadius? borders,
    Function()? onPressed, Widget child
  )
    :
    super(
      color: theme.getSurfaceColor(onPressed != null),
      borderRadius: borders,
      clipBehavior: borders != null ? Clip.hardEdge : Clip.none,
      child: InkResponse(
        focusColor: theme.hoverColor,
        hoverColor: theme.hoverColor,
        splashColor: theme.splashColor,
        highlightColor: Colors.transparent,
        highlightShape: BoxShape.rectangle,
        splashFactory: InkRipple.splashFactory,
        mouseCursor: SystemMouseCursors.basic,
        onTap: onPressed,
        child: Padding(padding: paddings, child: child)
      )
    );
}