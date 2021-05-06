import 'package:flutter/material.dart';
import 'package:spa_scaffold/spa_scaffold.dart';

abstract class AppTheme extends SpaTheme {
  String? get appLogoAsset;
}

class BlueGreyTheme extends AppTheme {
  @override
  Color get menuScrollbarColor => Colors.teal[200]!;
  @override
  Color get navigatorBackgroundColor => Color(0x47000000);

  @override
  Color get createAllShadowsColor => Colors.black54;
  @override
  Color get createMainMenuHeaderShadowColor => Colors.black54;
  @override
  Color get createPagesMenuHeaderFirstSelectedShadowColor => Colors.black54;
  @override
  Color get createPagesMenuHeaderFirstUnselectedShadowColor => Colors.black38;

  @override
  SpaRegionTheme get createHeaderTheme => SpaRegionTheme(
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

  @override
  SpaRegionTheme get createBarTheme => SpaRegionTheme(
    color: Colors.blueGrey[500],
    textButtonTheme: SpaTextButtonTheme(
      surfaceColor: Colors.blueGrey[700],
      hoverColor: Colors.blueGrey[800],
      splashColor: Colors.teal[400],
      iconColor: Colors.teal[200],
      textColor: Colors.grey[300],
      disabledContentColor: Colors.blueGrey[200]
    ),
    copyFrom: headerTheme
  );

  @override
  SpaRegionTheme get createContentTheme => SpaRegionTheme(
    color: Colors.blueGrey[100],
    titleColor: Colors.blueGrey[700],
    subtitleColor: Colors.black,
    scrollbarColor: Colors.teal[300],
    iconButtonTheme: SpaIconButtonTheme(
      iconColor: Colors.teal[300],
      copyFrom: headerTheme.iconButtonTheme
    ),
    switchTheme: SpaSwitchTheme(
      activeColor: Colors.teal[300],
      activeTrackColor: Colors.blueGrey[200],
      inactiveThumbColor: Colors.blueGrey[300],
      inactiveTrackColor: Colors.blueGrey[200],
      hoverColor: Colors.teal[200]
    ),
    radioTheme: SpaRadioTheme(
      enabledColor: Colors.teal[300],
      enabledHoveredColor: Colors.teal[500],
      disabledColor: Colors.blueGrey[200],
      hoverColor: Colors.teal[200]
    ),
    copyFrom: headerTheme
  );


  @override
  SpaIconButtonTheme get createIconButtonXHeaderTheme => SpaIconButtonTheme(
    hoverColor: Colors.red[500]!.withOpacity(0.5),
    splashColor: Colors.deepOrangeAccent,
    iconColor: Colors.red[200],
    copyFrom: headerTheme.iconButtonTheme
  );


  @override
  SpaTextButtonTheme get createTextButtonXBarTheme => SpaTextButtonTheme(
    splashColor: Colors.deepOrangeAccent,
    iconColor: Colors.red[200],
    textColor: Colors.red[200],
    copyFrom: barTheme.textButtonTheme
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
    disabledContentColor: Colors.blueGrey[200]
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
    textColor: Colors.blueGrey[200]
  );

  @override
  String? get mainMenuBackgroundAsset => 'main_menu_bkg_blue_grey.png';
  @override
  String? get sidebarPageBackgroundAsset => 'sidebar_page_bkg_blue_grey.png';

  @override
  String? get appLogoAsset => 'app_logo_blue_grey.png';
}

class BlueGreyDarkTheme extends BlueGreyTheme {
  @override
  Color get navigatorBackgroundColor => Color(0x33000000);

  @override
  SpaRegionTheme get createContentTheme => SpaRegionTheme(
    color: Colors.blueGrey[800],
    titleColor: Colors.blueGrey[300],
    subtitleColor: Colors.blueGrey[100],
    scrollbarColor: Colors.teal[200],
    iconButtonTheme: SpaIconButtonTheme(
      iconColor: Colors.teal[300],
      copyFrom: headerTheme.iconButtonTheme
    ),
    switchTheme: SpaSwitchTheme(
      activeColor: Colors.teal[200],
      activeTrackColor: Colors.blueGrey[300],
      inactiveThumbColor: Colors.blueGrey[200],
      inactiveTrackColor: Colors.blueGrey[300],
      hoverColor: Colors.teal[200]
    ),
    radioTheme: SpaRadioTheme(
      enabledColor: Colors.teal[200],
      enabledHoveredColor: Colors.blueGrey[100],
      disabledColor: Colors.blueGrey[300],
      hoverColor: Colors.teal[200]
    ),
    copyFrom: headerTheme
  );

  @override
  String? get appLogoAsset => 'app_logo_blue_grey_dark.png';
  @override
  String? get mainMenuBackgroundAsset => 'main_menu_bkg_blue_grey_dark.png';
}