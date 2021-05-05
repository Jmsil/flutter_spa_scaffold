import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

const double _titleFontSize = 14;
const double _normalFontSize = 13;

abstract class SpaTheme {
  Color get scrollbarColor;
  Color get navigatorBackgroundColor;

  @nonVirtual
  late final SpaRegionTheme headerTheme = createHeaderTheme;
  @protected
  SpaRegionTheme get createHeaderTheme;

  @nonVirtual
  late final SpaRegionTheme barTheme = createBarTheme;
  @protected
  SpaRegionTheme get createBarTheme;

  @nonVirtual
  late final SpaRegionTheme contentTheme = createContentTheme;
  @protected
  SpaRegionTheme get createContentTheme;


  @nonVirtual
  late final BoxShadow allShadows = BoxShadow(color: createAllShadowsColor, blurRadius: 6);
  @protected
  Color get createAllShadowsColor;

  @nonVirtual
  late final BoxShadow mainMenuHeaderShadow =
    _getMainMenuHeaderShadow(createMainMenuHeaderShadowColor);
  @protected
  Color get createMainMenuHeaderShadowColor;

  @nonVirtual
  late final BoxShadow pagesMenuHeaderFirstSelectedShadow =
    _getMainMenuHeaderShadow(createPagesMenuHeaderFirstSelectedShadowColor);
  @protected
  Color get createPagesMenuHeaderFirstSelectedShadowColor;

  @nonVirtual
  late final BoxShadow pagesMenuHeaderFirstUnselectedShadow =
    _getMainMenuHeaderShadow(createPagesMenuHeaderFirstUnselectedShadowColor);
  @protected
  Color get createPagesMenuHeaderFirstUnselectedShadowColor;


  @nonVirtual
  late final SpaIconButtonTheme iconButtonXHeaderTheme = createIconButtonXHeaderTheme;
  @protected
  SpaIconButtonTheme get createIconButtonXHeaderTheme;


  @nonVirtual
  late final SpaTextButtonTheme textButtonXBarTheme = createTextButtonXBarTheme;
  @protected
  SpaTextButtonTheme get createTextButtonXBarTheme;


  @nonVirtual
  late final SpaMenuItemTheme menuItemTheme = createMenuItemTheme;
  @protected
  SpaMenuItemTheme get createMenuItemTheme;

  @nonVirtual
  late final SpaMenuItemTheme menuItemSelectedPageTheme = createMenuItemSelectedPageTheme;
  @protected
  SpaMenuItemTheme get createMenuItemSelectedPageTheme;

  @nonVirtual
  late final SpaMenuItemTheme menuItemUnselectedPageTheme = createMenuItemUnselectedPageTheme;
  @protected
  SpaMenuItemTheme get createMenuItemUnselectedPageTheme;


  String? get mainMenuBackgroundAsset;
  String? get sidebarPageBackgroundAsset;


  static BoxShadow _getMainMenuHeaderShadow(Color color ) =>
    BoxShadow(color: color, offset: Offset(0, 3), blurRadius: 6);
}

class SpaRegionTheme {
  final Color color;
  final TextStyle titleStyle;
  final TextStyle subtitleStyle;
  final SpaIconButtonTheme iconButtonTheme;
  final SpaTextButtonTheme textButtonTheme;
  final SpaTabbarTheme tabbarTheme;
  final SpaSwitchTheme switchTheme;
  final SpaRadioTheme radioTheme;

  SpaRegionTheme({
    Color? color, Color? titleColor, Color? subtitleColor, SpaIconButtonTheme? iconButtonTheme,
    SpaTextButtonTheme? textButtonTheme, SpaTabbarTheme? tabbarTheme, SpaSwitchTheme? switchTheme,
    SpaRadioTheme? radioTheme, SpaRegionTheme? copyFrom
  })
    :
    this.color = color ?? copyFrom?.color ?? Colors.transparent,
    titleStyle = TextStyle(
      fontSize: _titleFontSize,
      color: titleColor ?? copyFrom?.titleStyle.color ?? Colors.transparent
    ),
    subtitleStyle = TextStyle(
      fontSize: _normalFontSize,
      color: subtitleColor ?? copyFrom?.subtitleStyle.color ?? Colors.transparent
    ),
    this.iconButtonTheme = iconButtonTheme ?? copyFrom?.iconButtonTheme ?? SpaIconButtonTheme(),
    this.textButtonTheme = textButtonTheme ?? copyFrom?.textButtonTheme ?? SpaTextButtonTheme(),
    this.tabbarTheme = tabbarTheme ?? copyFrom?.tabbarTheme ?? SpaTabbarTheme(),
    this.switchTheme = switchTheme ?? copyFrom?.switchTheme ?? SpaSwitchTheme(),
    this.radioTheme = radioTheme ?? copyFrom?.radioTheme ?? SpaRadioTheme();
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
      fontSize: _normalFontSize,
      color: textColor ?? copyFrom?._textStyle.color ?? Colors.transparent
    ),
    _disabledTextStyle = TextStyle(
      fontSize: _normalFontSize,
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
  final Color _selectedIconColor;
  final Color _unselectedIconColor;
  final TextStyle _selectedTextStyle;
  final TextStyle _unselectedTextStyle;
  final Color pressedColor;
  final Color borderColor;

  SpaTabbarTheme({
    Color? selectedColor, Color? unselectedColor, Color? selectedIconColor,
    Color? unselectedIconColor, Color? selectedTextColor, Color? unselectedTextColor,
    Color? pressedColor, Color? borderColor, SpaTabbarTheme? copyFrom
  })
    :
    this.selectedColor = selectedColor ?? copyFrom?.selectedColor ?? Colors.transparent,
    this.unselectedColor = unselectedColor ?? copyFrom?.unselectedColor ?? Colors.transparent,
    _selectedIconColor = selectedIconColor ?? copyFrom?._selectedIconColor ?? Colors.transparent,
    _unselectedIconColor =
      unselectedIconColor ?? copyFrom?._unselectedIconColor ?? Colors.transparent,
    _selectedTextStyle = TextStyle(
      fontSize: _normalFontSize,
      color: selectedTextColor ?? copyFrom?._selectedTextStyle.color ?? Colors.transparent
    ),
    _unselectedTextStyle = TextStyle(
      fontSize: _normalFontSize,
      color: unselectedTextColor ?? copyFrom?._unselectedTextStyle.color ?? Colors.transparent
    ),
    this.pressedColor = pressedColor ?? copyFrom?.pressedColor ?? Colors.transparent,
    this.borderColor = borderColor ?? copyFrom?.borderColor ?? Colors.transparent;

  Color getIconColor(bool selected) => selected ? _selectedIconColor : _unselectedIconColor;
  TextStyle getTextStyle(bool selected) => selected ? _selectedTextStyle : _unselectedTextStyle;
}

class SpaSwitchTheme {
  final Color activeColor;
  final Color activeTrackColor;
  final Color inactiveThumbColor;
  final Color inactiveTrackColor;
  final Color hoverColor;

  SpaSwitchTheme({
    Color? activeColor, Color? activeTrackColor, Color? inactiveThumbColor,
    Color? inactiveTrackColor, Color? hoverColor, SpaSwitchTheme? copyFrom
  })
    :
    this.activeColor = activeColor ?? copyFrom?.activeColor ?? Colors.transparent,
    this.activeTrackColor = activeTrackColor ?? copyFrom?.activeTrackColor ?? Colors.transparent,
    this.inactiveThumbColor =
      inactiveThumbColor ?? copyFrom?.inactiveThumbColor ?? Colors.transparent,
    this.inactiveTrackColor =
      inactiveTrackColor ?? copyFrom?.inactiveTrackColor ?? Colors.transparent,
    this.hoverColor = hoverColor?.withOpacity(0.5) ?? copyFrom?.hoverColor ?? Colors.transparent;
}

class SpaRadioTheme {
  final Color _enabledColor;
  final Color _enabledHoveredColor;
  final Color _disabledColor;
  final Color hoverColor;

  SpaRadioTheme({
    Color? enabledColor, Color? enabledHoveredColor, Color? disabledColor, Color? hoverColor,
    SpaRadioTheme? copyFrom
  })
    :
    this._enabledColor = enabledColor ?? copyFrom?._enabledColor ?? Colors.transparent,
    this._enabledHoveredColor =
      enabledHoveredColor ?? enabledColor ??
      copyFrom?._enabledHoveredColor ?? copyFrom?._enabledColor ??
      Colors.transparent,
    this._disabledColor = disabledColor ?? copyFrom?._disabledColor ?? Colors.transparent,
    this.hoverColor = hoverColor?.withOpacity(0.5) ?? copyFrom?.hoverColor ?? Colors.transparent;

  Color getColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled))
      return _disabledColor;

    if (states.contains(MaterialState.hovered) || states.contains(MaterialState.focused))
      return _enabledHoveredColor;

    return _enabledColor;
  }
}