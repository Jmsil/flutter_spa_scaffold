import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa_scaffold/src/page/menu_page.dart';
import 'package:spa_scaffold/src/page/settings_page/settings_model.dart';
import 'package:spa_scaffold/src/ui/button.dart';
import 'package:spa_scaffold/src/ui/dialogs.dart';
import 'package:spa_scaffold/src/ui/separator.dart';
import 'package:spa_scaffold/src/ui/strings.dart';

abstract class SpaRegistrationPage extends SpaMenuPage {
  SpaRegistrationPage(IconData icon) : super(icon);

  @override
  List<Widget> menuBuilder(BuildContext context) {
    final SpaSettingsModel mSets = context.watch<SpaSettingsModel>();
    return [
      SpaTextButton(
        Icons.save_outlined, mSets.strings.record, mSets.theme.barTheme.textButtonTheme,
        getMenuAction(context, () => _record(context, mSets))
      ),
      SpaSep.sep4,
      SpaTextButton(
        Icons.close_outlined, mSets.strings.cancel, mSets.theme.barTheme.textButtonTheme,
        getMenuAction(context, () => _cancel(context, mSets))
      ),
      SpaSep.sep4,
      SpaTextButton(
        Icons.delete_outlined, mSets.strings.delete, mSets.theme.textButtonXBarTheme,
        getMenuAction(context, () => _delete(context))
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


  void _record(BuildContext context, SpaSettingsModel mSets) async {
    String? validationMessage = onValidate();
    if (validationMessage != null) {
      SpaDialogs.showMessage(context, mSets.strings.invalidData, validationMessage);
      return;
    }

    RegistrationPageActionReturn result = await onRecord();
    await SpaDialogs.showMessage(
      context,
      result.isSuccess ? mSets.strings.success : mSets.strings.error,
      result.message ??
        (result.isSuccess ? mSets.strings.recordSuccessMessage : mSets.strings.recordErrorMessage)
    );

    if (result.isSuccess)
      onClear();
  }

  void _cancel(BuildContext context, SpaSettingsModel mSets) async {
    if (
      await SpaDialogs.showQuestion(
        context, mSets.strings.cancel, mSets.strings.editCancelQuestion
      ) == SpaQuestionDialogReturn.yes
    )
      onClear();
  }

  void _delete(BuildContext context) async {
    final SpaStrings strings = context.read<SpaSettingsModel>().strings;

    if (
      await SpaDialogs.showQuestion(
        context, strings.delete, strings.editDeleteQuestion
      ) == SpaQuestionDialogReturn.no
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