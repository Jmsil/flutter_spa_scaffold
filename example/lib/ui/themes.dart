import 'package:flutter/material.dart';
import 'package:spa_scaffold/spa_scaffold.dart';

abstract class AppTheme extends SpaTheme {}

class BlueGreyTheme extends AppTheme {
  @override Color get homeBackgroundColor => Colors.blueGrey[100]!;
  @override Color get scrollbarColor => Colors.teal[200]!;
  @override Color get navigatorBackgroundColor => Color(0x47000000);

  @override Color get createAllShadowsColor => Colors.black54;
  @override Color get createMainMenuHeaderShadowColor => Colors.black54;
  @override Color get createPagesMenuHeaderFirstSelectedShadowColor => Colors.black54;
  @override Color get createPagesMenuHeaderFirstUnselectedShadow => Colors.black38;

  // TODO: Adjust headerPanelTheme's properties.
  @override
  SpaPanelTheme get createHeaderPanelTheme => SpaPanelTheme(
    color: Colors.blueGrey[700],
    titleColor: Colors.blueGrey[100],
    subtitleColor: Colors.blueGrey[200],
    iconButtonTheme: SpaIconButtonTheme(
      hoverColor: Colors.blueGrey[500],
      splashColor: Colors.teal[400],
      iconColor: Colors.teal[200],
      disabledIconColor: Colors.blueGrey[400]
    ),
    tabbarTheme: SpaTabbarTheme(
      selectedColor: Colors.blueGrey[500],
      unselectedColor: Colors.blueGrey[800],
      selectedIconColor: Colors.teal[200],
      unselectedIconColor: Colors.blueGrey[400],
      selectedTextColor: Colors.grey[300],
      unselectedTextColor: Colors.blueGrey[200],
      pressedColor: Colors.blueGrey[700],
      borderColor: Colors.blueGrey[400]
    )
  );

  // TODO: Adjust barPanelTheme's properties.
  @override
  SpaPanelTheme get createBarPanelTheme => SpaPanelTheme(
    color: Colors.blueGrey[500],
    textButtonTheme: SpaTextButtonTheme(
      surfaceColor: Colors.blueGrey[700],
      hoverColor: Colors.blueGrey[800],
      splashColor: Colors.teal[400],
      iconColor: Colors.teal[200],
      textColor: Colors.grey[300],
      disabledContentColor: Colors.blueGrey[200]
    ),
    copyFrom: headerPanelTheme
  );

  // TODO: Adjust contentPanelTheme properties.
  @override
  SpaPanelTheme get createContentPanelTheme => SpaPanelTheme(
    color: Colors.blueGrey[100],
    titleColor: Colors.black,
    subtitleColor: Colors.grey[900],
    iconButtonTheme: SpaIconButtonTheme(
      iconColor: Colors.teal[300],
      copyFrom: headerPanelTheme.iconButtonTheme
    ),
    copyFrom: headerPanelTheme
  );


  @override
  SpaIconButtonTheme get createIconButtonXHeaderTheme => SpaIconButtonTheme(
    hoverColor: Colors.red[500]!.withOpacity(0.5),
    splashColor: Colors.deepOrangeAccent,
    iconColor: Colors.red[200],
    copyFrom: headerPanelTheme.iconButtonTheme
  );


  @override
  SpaTextButtonTheme get createTextButtonXBarTheme => SpaTextButtonTheme(
    splashColor: Colors.deepOrangeAccent,
    iconColor: Colors.red[200],
    textColor: Colors.red[200],
    copyFrom: barPanelTheme.textButtonTheme
  );


  // TODO: Adjust disabled menuItemTheme colors.
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

  String? get mainMenuBackgroundAsset => 'main_menu_bkg_blue_grey.png';
  String? get sidebarPageBackgroundAsset => 'sidebar_page_bkg_blue_grey.png';
}