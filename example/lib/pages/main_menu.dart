import 'package:example/pages/page1.dart' deferred as page1;
import 'package:example/pages/page_2/page2.dart' deferred as page2;
import 'package:example/ui/strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa_scaffold/spa_scaffold.dart';

SpaMainMenuGroup getMainMenu(BuildContext context) {
  final AppStrings strings = context.read<SpaSettingsModel>().appStrings;
  final SpaMainMenuGroup root = SpaMainMenuGroup(Icons.menu_outlined, '');

  root.addGroup(SpaMainMenuGroup(Icons.edit_outlined, strings.groupMenuItem1))
    ..addAction(
      SpaMainMenuAction(
        Icons.edit_outlined, strings.actionMenuItem1, page1.loadLibrary,
        (icon) => page1.Page1(icon)
      )
    );

  root.addGroup(SpaMainMenuGroup(Icons.analytics_outlined, strings.groupMenuItem2))
    ..addAction(
      SpaMainMenuAction(
        Icons.analytics_outlined, strings.actionMenuItem2, page2.loadLibrary,
        (icon) => page2.Page2(icon)
      )
    );

  return root;
}