import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

abstract class SpaPage<T extends State> extends StatefulWidget {
  final IconData icon;
  final String title;

  SpaPage(this.icon, this.title) : super(key: GlobalKey<T>());

  @override
  T createState();

  @nonVirtual
  T get state => ((key as GlobalKey).currentState as T);

  Function()? get overflowMenuAction => null;

  void resetOverflowMenuAction() {}
}