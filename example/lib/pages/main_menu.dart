import 'package:example/pages/page1.dart';
import 'package:example/pages/page2.dart';
import 'package:example/ui/strings.dart';
import 'package:flutter/material.dart';
import 'package:spa_scaffold/spa_scaffold.dart';

List<SpaMainMenuItem> getMainMenuItems(Strings strings) {
  final List<SpaMainMenuItem> root = [];

  final SpaMainMenuGroup group1 = SpaMainMenuGroup(Icons.edit, strings.groupMenuItem1);
  root.add(group1);

  group1.items.add(SpaMainMenuAction<Page1>(
    Icons.edit, strings.actionMenuItem1, (icon) => Page1(icon, strings.pageTitle1)
  ));


  final SpaMainMenuGroup group2 = SpaMainMenuGroup(Icons.article, strings.groupMenuItem2);
  root.add(group2);

  group2.items.add(SpaMainMenuAction<Page2>(
    Icons.article, strings.actionMenuItem2, (icon) => Page2(icon, strings.pageTitle2)
  ));


  return root;
}