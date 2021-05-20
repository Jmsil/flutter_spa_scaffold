import 'package:flutter/material.dart';

class SpaScrollbar extends RawScrollbar {
  SpaScrollbar(Color color, ScrollController controller, Widget child)
    :
    super(
      thickness: 4,
      thumbColor: color,
      controller: controller,
      child: child
    );
}