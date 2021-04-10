import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:spa_scaffold/spa_scaffold.dart';

abstract class AppTheme extends SpaTheme {
  late final SpaTextButtonTheme textButtonXBarTheme = createTextButtonXBarTheme;
  @protected
  SpaTextButtonTheme get createTextButtonXBarTheme;
}

class BlueGreyTheme extends AppTheme {
  @override Color get homeBackgroundColor => Colors.blueGrey[100]!;
  @override Color get headerPanelColor => Colors.blueGrey[700]!;
  @override Color get barPanelColor => Colors.blueGrey[500]!;
  @override Color get contentPanelColor => Colors.blueGrey[100]!;
  @override Color get menuPanelColor => Colors.blueGrey[100]!;
  @override Color get scrollbarColor => Colors.teal[200]!;
  @override Color get createHeaderTitleColor => Colors.blueGrey[100]!;
  @override Color get createHeaderSubtitleColor => Colors.blueGrey[200]!;
  @override Color get createAllShadowsColor => Colors.black54;
  @override Color get createMainMenuHeaderShadowColor => Colors.black54;
  @override Color get createPagesMenuHeaderFirstSelectedShadowColor => Colors.black54;
  @override Color get createPagesMenuHeaderFirstUnselectedShadow => Colors.black38;

  @override
  SpaIconButtonTheme get createIconButtonHeaderTheme => SpaIconButtonTheme(
    hoverColor: Colors.blueGrey[500],
    splashColor: Colors.teal[400],
    iconColor: Colors.teal[200],
    disabledIconColor: Colors.blueGrey[400]
  );

  @override
  SpaIconButtonTheme get createIconButtonXHeaderTheme => SpaIconButtonTheme(
    hoverColor: Colors.red[500]!.withOpacity(0.5),
    splashColor: Colors.deepOrangeAccent,
    iconColor: Colors.red[200],
    copyFrom: iconButtonHeaderTheme
  );

  @override
  SpaTextButtonTheme get createTextButtonBarTheme => SpaTextButtonTheme(
    surfaceColor: Colors.blueGrey[700],
    hoverColor: Colors.blueGrey[800],
    splashColor: Colors.teal[400],
    iconColor: Colors.teal[200],
    textColor: Colors.grey[300],
    disabledContentColor: Colors.blueGrey[200]
  );

  @override
  SpaMenuItemTheme get createMenuItemTheme => SpaMenuItemTheme(
    surfaceColor: Colors.blueGrey[500],
    disabledSurfaceColor: Colors.blueGrey[500],
    hoverColor: Colors.blueGrey[400],
    splashColor: Colors.teal[600],
    iconColor: Colors.teal[200],
    textColor: Colors.grey[300],
    trailingIconColor: Colors.blueGrey[200],
    disabledContentColor: Colors.blueGrey[400]
  );

  // TODO: Adjust disabled menuItemTheme colors.
  @override
  SpaMenuItemTheme get createMenuItemSelectedPageTheme => SpaMenuItemTheme(
    hoverColor: Colors.transparent,
    copyFrom: menuItemTheme
  );

  @override
  SpaMenuItemTheme get createMenuItemUnselectedPageTheme => SpaMenuItemTheme(
    surfaceColor: Colors.blueGrey[700],
    hoverColor: Colors.blueGrey[600],
    splashColor: Colors.blueGrey[300],
    iconColor: Colors.blueGrey[400],
    textColor: Colors.blueGrey[200],
    copyFrom: menuItemTheme
  );

  @override
  SpaTabbarTheme get createActivePagesBarTheme => SpaTabbarTheme(
    selectedColor: Colors.blueGrey[500],
    unselectedColor: Colors.blueGrey[800],
    selectedTextColor: Colors.grey[300],
    unselectedTextColor: Colors.blueGrey[200],
    pressedColor: Colors.blueGrey[700],
    borderColor: Colors.blueGrey[400]
  );


  @override
  SpaTextButtonTheme get createTextButtonXBarTheme => SpaTextButtonTheme(
    splashColor: Colors.deepOrangeAccent,
    iconColor: Colors.red[200],
    copyFrom: textButtonBarTheme
  );
}