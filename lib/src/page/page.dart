import 'package:flutter/material.dart';

abstract class SpaPage extends StatefulWidget {
  final IconData icon;
  final String title;

  SpaPage(this.icon, this.title);

  Function()? get overflowMenuAction => null;

  void resetOverflowMenuAction() {}
}