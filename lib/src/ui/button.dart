import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:spa_scaffold/src/ui/separator.dart';
import 'package:spa_scaffold/src/ui/text.dart';
import 'package:spa_scaffold/src/ui/theme.dart';
import 'package:spa_scaffold/src/ui/window.dart';

final EdgeInsets _iconTextPaddings = SpaWin.parsePaddings(-1, -1, 12, -1);
final EdgeInsets _menuItemTrailingPaddings = SpaWin.parsePaddings(-1, -1, 4, -1);

class SpaIconButton extends _ButtonFrame {
  SpaIconButton(IconData icon, SpaIconButtonTheme theme, Function()? onPressed)
    :
    super(
      theme, SpaWin.allPaddings, SpaWin.allBorders, onPressed,
      Icon(icon, color: theme.getIconColor(onPressed != null))
    );
}


class SpaTextButton extends _ButtonFrame {
  SpaTextButton(
    IconData icon, String text, SpaTextButtonTheme theme, Function()? onPressed,
    {bool isCenter = false, BorderRadius? borders}
  )
    :
    super(
      theme, _iconTextPaddings, borders, onPressed,
      Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: isCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          Icon(icon, color: theme.getIconColor(onPressed != null)),
          SpaSep.sep12,
          Flexible(
            child: SpaText(text, theme.getTextStyle(onPressed != null))
          )
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
          SpaSep.sep12,
          Expanded(
            child: SpaText(text, theme.getTextStyle(onPressed != null))
          ),

          if (trailingIcon != null)
            ...[
              SpaSep.sep12,
              Icon(trailingIcon, color: theme.getTrailingIconColor(onPressed != null))
            ],
        ]
      )
    );

  SpaMenuItem.icon(IconData icon, SpaMenuItemTheme theme, Function()? onPressed)
    :
    super(
      theme, SpaWin.allPaddings, null, onPressed,
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
        child: Padding(
          padding: paddings,
          child: child
        )
      )
    );
}