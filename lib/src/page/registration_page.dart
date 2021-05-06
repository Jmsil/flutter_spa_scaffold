import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa_scaffold/src/page/sidebar_page.dart';
import 'package:spa_scaffold/src/ui/button.dart';
import 'package:spa_scaffold/src/ui/dialogs.dart';
import 'package:spa_scaffold/src/ui/separator.dart';
import 'package:spa_scaffold/src/ui/strings.dart';
import 'package:spa_scaffold/src/ui/theme.dart';

abstract class SpaRegistrationPage extends SpaSidebarPage {
  SpaRegistrationPage(IconData icon, String title) : super(icon, title);

  @override
  SpaRegistrationPageState createState();
}

abstract class SpaRegistrationPageState<T extends SpaRegistrationPage>
  extends SpaSidebarPageState<T>
{
  @override
  List<Widget> sidebarBuilder(BuildContext context) {
    final SpaTheme theme = context.watch<SpaTheme>();
    final SpaStrings strings = context.read<SpaStrings>();

    return [
      SpaTextButton(
        Icons.save, strings.record, theme.barTheme.textButtonTheme,
        getBarAction(_record)
      ),
      SpaSep.sep4,
      SpaTextButton(
        Icons.cancel, strings.cancel, theme.barTheme.textButtonTheme,
        getBarAction(_cancel)
      ),
      SpaSep.sep4,
      SpaTextButton(
        Icons.delete_forever, strings.delete, theme.textButtonXBarTheme,
        getBarAction(_delete)
      )
    ];
  }

  @protected
  Future<RegistrationPageActionReturn> onRecord();

  @protected
  void onClear();

  @protected
  String? onValidate();

  @protected
  Future<RegistrationPageActionReturn> onDelete();


  void _record() async {
    final SpaStrings strings = context.read<SpaStrings>();

    String? validationMessage = onValidate();
    if (validationMessage != null) {
      SpaDialogs.showMessage(context, strings.invalidData, validationMessage);
      return;
    }

    RegistrationPageActionReturn result = await onRecord();
    await SpaDialogs.showMessage(
      context,
      result.isSuccess ? strings.success : strings.error,
      result.message ??
        (result.isSuccess ? strings.recordSuccessMessage : strings.recordErrorMessage)
    );

    if (result.isSuccess)
      onClear();
  }

  void _cancel() async {
    final SpaStrings strings = context.read<SpaStrings>();
    if (
      await SpaDialogs.showQuestion(context, strings.cancel, strings.editCancelQuestion) ==
        SpaQuestionDialogReturn.yes
    )
      onClear();
  }

  void _delete() async {
    final SpaStrings strings = context.read<SpaStrings>();

    if (
      await SpaDialogs.showQuestion(context, strings.delete, strings.editDeleteQuestion) ==
        SpaQuestionDialogReturn.no
    )
      return;

    RegistrationPageActionReturn result = await onDelete();
    await SpaDialogs.showMessage(
      context,
      result.isSuccess ? strings.success : strings.error,
      result.message ??
        (result.isSuccess ? strings.deleteSuccessMessage : strings.deleteErrorMessage)
    );

    if (result.isSuccess)
      onClear();
  }
}

class RegistrationPageActionReturn {
  final bool isSuccess;
  final String? message;
  RegistrationPageActionReturn(this.isSuccess, [this.message]);
}