import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';
import 'package:spa_scaffold/src/ui/strings.dart';

abstract class SpaPage<T extends ChangeNotifier> extends StatelessWidget {
  final IconData icon;
  @protected
  final T? model;

  SpaPage(this.icon, [this.model]);

  @override @nonVirtual
  Widget build(BuildContext context) {
    if (model == null)
      return pageBuilder(context);

    return ChangeNotifierProvider<T>.value(
      value: model!,
      builder: (context, child) {
        context.watch<T>();
        return pageBuilder(context);
      }
    );
  }

  @protected
  Widget pageBuilder(BuildContext context);

  String getTitle(SpaStrings strings);

  Function()? getOverflowMenuAction(BuildContext context) => null;

  void resetOverflowMenuAction() {}
}