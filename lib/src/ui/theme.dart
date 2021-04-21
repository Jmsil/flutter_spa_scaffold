import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

abstract class SpaTheme {
  static const double _titleFontSize = 14;
  static const double _normalFontSize = 13;


  Color get homeBackgroundColor;
  Color get headerPanelColor;
  Color get barPanelColor;
  Color get contentPanelColor;
  Color get menuPanelColor;
  Color get scrollbarColor;

  late final TextStyle headerTitleStyle =
    TextStyle(fontSize: _titleFontSize, color: createHeaderTitleColor);
  @protected
  Color get createHeaderTitleColor;

  late final TextStyle headerSubtitleStyle =
    TextStyle(fontSize: _normalFontSize, color: createHeaderSubtitleColor);
  @protected
  Color get createHeaderSubtitleColor;


  late final BoxShadow allShadows = BoxShadow(color: createAllShadowsColor, blurRadius: 6);
  @protected
  Color get createAllShadowsColor;

  late final BoxShadow mainMenuHeaderShadow =
    _getMainMenuHeaderShadow(createMainMenuHeaderShadowColor);
  @protected
  Color get createMainMenuHeaderShadowColor;

  late final BoxShadow pagesMenuHeaderFirstSelectedShadow =
    _getMainMenuHeaderShadow(createPagesMenuHeaderFirstSelectedShadowColor);
  @protected
  Color get createPagesMenuHeaderFirstSelectedShadowColor;

  late final BoxShadow pagesMenuHeaderFirstUnselectedShadow =
    _getMainMenuHeaderShadow(createPagesMenuHeaderFirstUnselectedShadow);
  @protected
  Color get createPagesMenuHeaderFirstUnselectedShadow;


  late final SpaIconButtonTheme iconButtonHeaderTheme = createIconButtonHeaderTheme;
  @protected
  SpaIconButtonTheme get createIconButtonHeaderTheme;

  late final SpaIconButtonTheme iconButtonXHeaderTheme = createIconButtonXHeaderTheme;
  @protected
  SpaIconButtonTheme get createIconButtonXHeaderTheme;


  late final SpaTextButtonTheme textButtonBarTheme = createTextButtonBarTheme;
  @protected
  SpaTextButtonTheme get createTextButtonBarTheme;

  late final SpaTextButtonTheme textButtonXBarTheme = createTextButtonXBarTheme;
  @protected
  SpaTextButtonTheme get createTextButtonXBarTheme;


  late final SpaMenuItemTheme menuItemTheme = createMenuItemTheme;
  @protected
  SpaMenuItemTheme get createMenuItemTheme;

  late final SpaMenuItemTheme menuItemSelectedPageTheme = createMenuItemSelectedPageTheme;
  @protected
  SpaMenuItemTheme get createMenuItemSelectedPageTheme;

  late final SpaMenuItemTheme menuItemUnselectedPageTheme = createMenuItemUnselectedPageTheme;
  @protected
  SpaMenuItemTheme get createMenuItemUnselectedPageTheme;


  late final SpaTabbarTheme activePagesBarTheme = createActivePagesBarTheme;
  @protected
  SpaTabbarTheme get createActivePagesBarTheme;


  static BoxShadow _getMainMenuHeaderShadow(Color color ) =>
    BoxShadow(color: color, offset: Offset(0, 5), blurRadius: 6, spreadRadius: -2);
}


class SpaTouchableWidgetTheme {
  final Color _surfaceColor;
  final Color _disabledSurfaceColor;
  final Color hoverColor;
  final Color splashColor;

  SpaTouchableWidgetTheme({
    Color? surfaceColor, Color? disabledSurfaceColor, Color? hoverColor, Color? splashColor,
    SpaTouchableWidgetTheme? copyFrom
  })
    :
    _surfaceColor = surfaceColor ?? copyFrom?._surfaceColor ?? Colors.transparent,
    _disabledSurfaceColor =
      disabledSurfaceColor ?? copyFrom?._disabledSurfaceColor ?? Colors.transparent,
    this.hoverColor = hoverColor ?? copyFrom?.hoverColor ?? Colors.transparent,
    this.splashColor =
      splashColor?.withOpacity(0.35) ?? copyFrom?.splashColor ?? Colors.transparent;

  Color getSurfaceColor(bool enabled) => enabled ? _surfaceColor : _disabledSurfaceColor;
}


class SpaIconButtonTheme extends SpaTouchableWidgetTheme {
  final Color _iconColor;
  final Color _disabledIconColor;

  SpaIconButtonTheme({
    Color? surfaceColor, Color? disabledSurfaceColor, Color? hoverColor, Color? splashColor,
    Color? iconColor, Color? disabledIconColor, SpaIconButtonTheme? copyFrom
  })
    :
    _iconColor = iconColor ?? copyFrom?._iconColor ?? Colors.transparent,
    _disabledIconColor = disabledIconColor ?? copyFrom?._disabledIconColor ?? Colors.transparent,
    super(
      surfaceColor: surfaceColor,
      disabledSurfaceColor: disabledSurfaceColor,
      hoverColor: hoverColor,
      splashColor: splashColor,
      copyFrom: copyFrom
    );

  Color getIconColor(bool enabled) => enabled ? _iconColor : _disabledIconColor;
}


class SpaTextButtonTheme extends SpaIconButtonTheme {
  final TextStyle _textStyle;
  final TextStyle _disabledTextStyle;

  SpaTextButtonTheme({
    Color? surfaceColor, Color? disabledSurfaceColor, Color? hoverColor, Color? splashColor,
    Color? iconColor, Color? textColor, Color? disabledContentColor, SpaTextButtonTheme? copyFrom
  })
    :
    _textStyle = TextStyle(
      fontSize: SpaTheme._normalFontSize,
      color: textColor ?? copyFrom?._textStyle.color ?? Colors.transparent
    ),
    _disabledTextStyle = TextStyle(
      fontSize: SpaTheme._normalFontSize,
      color: disabledContentColor ?? copyFrom?._disabledTextStyle.color ?? Colors.transparent
    ),
    super(
      surfaceColor: surfaceColor,
      disabledSurfaceColor: disabledSurfaceColor,
      hoverColor: hoverColor,
      splashColor: splashColor,
      iconColor: iconColor,
      disabledIconColor: disabledContentColor?.withOpacity(0.65),
      copyFrom: copyFrom
    );

  TextStyle getTextStyle(bool enabled) => enabled ? _textStyle : _disabledTextStyle;
}


class SpaMenuItemTheme extends SpaTextButtonTheme {
  final Color _trailingIconColor;

  SpaMenuItemTheme({
    Color? surfaceColor, Color? disabledSurfaceColor, Color? hoverColor, Color? splashColor,
    Color? iconColor, Color? textColor, Color? trailingIconColor, Color? disabledContentColor,
    SpaMenuItemTheme? copyFrom
  })
    :
    _trailingIconColor = trailingIconColor ?? copyFrom?._trailingIconColor ?? Colors.transparent,
    super(
      surfaceColor: surfaceColor,
      disabledSurfaceColor: disabledSurfaceColor,
      hoverColor: hoverColor,
      splashColor: splashColor,
      iconColor: iconColor,
      textColor: textColor,
      disabledContentColor: disabledContentColor,
      copyFrom: copyFrom
    );

  Color getTrailingIconColor(bool enabled) => enabled ? _trailingIconColor : _disabledIconColor;
}


class SpaTabbarTheme {
  final Color selectedColor;
  final Color unselectedColor;
  final TextStyle _selectedTextStyle;
  final TextStyle _unselectedTextStyle;
  final Color pressedColor;
  final Color borderColor;

  SpaTabbarTheme({
    Color? selectedColor, Color? unselectedColor, Color? selectedTextColor,
    Color? unselectedTextColor, Color? pressedColor, Color? borderColor, SpaTabbarTheme? copyFrom
  })
    :
    this.selectedColor = selectedColor ?? copyFrom?.selectedColor ?? Colors.transparent,
    this.unselectedColor = unselectedColor ?? copyFrom?.unselectedColor ?? Colors.transparent,
    _selectedTextStyle = TextStyle(
      fontSize: SpaTheme._normalFontSize,
      color: selectedTextColor ?? copyFrom?._selectedTextStyle.color ?? Colors.transparent
    ),
    _unselectedTextStyle = TextStyle(
      fontSize: SpaTheme._normalFontSize,
      color: unselectedTextColor ?? copyFrom?._unselectedTextStyle.color ?? Colors.transparent
    ),
    this.pressedColor = pressedColor ?? copyFrom?.pressedColor ?? Colors.transparent,
    this.borderColor = borderColor ?? copyFrom?.borderColor ?? Colors.transparent;

  TextStyle getTextStyle(bool selected) => selected ? _selectedTextStyle : _unselectedTextStyle;
}