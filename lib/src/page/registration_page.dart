import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';
import 'package:spa_scaffold/src/page/sidebar_page.dart';
import 'package:spa_scaffold/src/ui/button.dart';
import 'package:spa_scaffold/src/ui/strings.dart';
import 'package:spa_scaffold/src/ui/theme.dart';
import 'package:spa_scaffold/src/ui/dialogs.dart';

abstract class SpaRegistrationPage extends SpaSidebarPage {
  SpaRegistrationPage(IconData icon, String title) : super(icon, title);

  @override
  SpaRegistrationPageState createState();
}

abstract class SpaRegistrationPageState<T extends SpaRegistrationPage>
  extends SpaSidebarPageState<T>
{
  @override @nonVirtual
  List<Widget> sidebarBuilder(BuildContext context) {
    final SpaTheme theme = context.read<SpaTheme>();
    final SpaStrings strings = context.read<SpaStrings>();

    return [
      SpaTextButton(
        Icons.save, strings.record, theme.textButtonBarTheme,
        () => performAction(_record)
      ),
      SpaSidebarPageState.defaultSeparator,
      SpaTextButton(
        Icons.cancel, strings.cancel, theme.textButtonBarTheme,
        () => performAction(_cancel)
      ),
      SpaSidebarPageState.defaultSeparator,
      SpaTextButton(
        Icons.delete_forever, strings.delete, theme.textButtonXBarTheme,
        () => performAction(_delete)
      )
    ];
  }

  @protected
  Future<RegistrationPageActionReturn> onRecord();

  @protected
  void onCancel();

  @protected
  Future<RegistrationPageActionReturn> onDelete();

  void _record() async {
    RegistrationPageActionReturn result = await onRecord();
    SpaDialogs.showOkCancel(context);
  }

  void _cancel() {
    onCancel();
  }

  void _delete() async {
    RegistrationPageActionReturn result = await onDelete();
  }
}

class RegistrationPageActionReturn {
  final bool isSuccess;
  final String message;
  RegistrationPageActionReturn(this.isSuccess, this.message);
}