import 'package:flutter/material.dart';

class SpaWindow {
  static const double _margin = 8;
  static const double _padding = 8;
  static const Radius _radius = Radius.circular(8);

  static const EdgeInsets allMargins = EdgeInsets.all(_margin);
  static const EdgeInsets allPaddings = EdgeInsets.all(_padding);
  static const BorderRadius allBorders = BorderRadius.all(_radius);

  static EdgeInsets parseMargins(double l, double t, double r, double b) =>
    _parse(l, t, r, b, _margin);

  static EdgeInsets parsePaddings(double l, double t, double r, double b) =>
    _parse(l, t, r, b, _padding);

  static EdgeInsets _parse(double l, double t, double r, double b, double defaultValue) {
    return EdgeInsets.fromLTRB(
      l < 0 ? defaultValue : l,
      t < 0 ? defaultValue : t,
      r < 0 ? defaultValue : r,
      b < 0 ? defaultValue : b
    );
  }

  static BorderRadius parseBorders(double a, double b, double c, double d) {
    Radius parse(double v) => v < 0 ? _radius : v == 0 ? Radius.zero : Radius.circular(v);
    return BorderRadius.only(
      topLeft: parse(a),
      topRight: parse(b),
      bottomLeft: parse(c),
      bottomRight : parse(d)
    );
  }
}

extension WinSpec on BuildContext {
  bool get isLargeScreen => MediaQuery.of(this).size.width >= 1024;
  bool get isTallScreen => MediaQuery.of(this).size.height >= 540;
}