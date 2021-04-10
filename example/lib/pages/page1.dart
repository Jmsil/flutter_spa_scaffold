import 'package:example/ui/strings.dart';
import 'package:example/ui/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa_scaffold/spa_scaffold.dart';

class Page1 extends SpaSidebarPage<_Page1State> {
  Page1(IconData icon, String title) : super(icon, title);

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends SpaSidebarPageState {
  @override
  List<Widget> sidebarBuilder(BuildContext context) {
    final AppTheme theme = context.read<AppTheme>();
    final Strings strings = context.read<Strings>();

    return [
      SpaTextButton(Icons.add, strings.newAction, theme.textButtonBarTheme, () => popDrawer()),
      SpaSeparator(0.5),
      SpaTextButton(Icons.edit, strings.editAction, theme.textButtonBarTheme, () => popDrawer()),
      SpaSeparator(0.5),
      SpaTextButton(
        Icons.delete_forever, strings.deleteAction, theme.textButtonXBarTheme, () => popDrawer()
      ),
      SpaSeparator(0.5),
      SpaTextButton(
        Icons.closed_caption_disabled, strings.disabledAction, theme.textButtonBarTheme, null
      )
    ];
  }

  @override
  Widget contentBuilder(BuildContext context) {
    return Center();
  }
}