import 'package:example/pages/page1.dart' deferred as page1;
import 'package:example/pages/page2.dart' deferred as page2;
import 'package:example/ui/strings.dart';
import 'package:flutter/material.dart';
import 'package:spa_scaffold/spa_scaffold.dart';

SpaMainMenuGroup getMainMenu(Strings strings) {
  final SpaMainMenuGroup root = SpaMainMenuGroup(Icons.menu, '');

  root.addGroup(SpaMainMenuGroup(Icons.edit, strings.groupMenuItem1))
    ..addAction(
      SpaMainMenuAction(
        Icons.edit, strings.actionMenuItem1, page1.loadLibrary,
        (icon) => page1.Page1(icon, strings.pageTitle1)
      )
    );

  root.addGroup(SpaMainMenuGroup(Icons.article, strings.groupMenuItem2))
    ..addAction(
      SpaMainMenuAction(
        Icons.article, strings.actionMenuItem2, page2.loadLibrary,
        (icon) => page2.Page2(icon, strings.pageTitle2)
      )
    );

  return root;
}