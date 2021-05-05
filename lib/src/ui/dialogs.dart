import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa_scaffold/src/page/settings_model.dart';
import 'package:spa_scaffold/src/ui/button.dart';
import 'package:spa_scaffold/src/ui/panel.dart';
import 'package:spa_scaffold/src/ui/separator.dart';
import 'package:spa_scaffold/src/ui/strings.dart';
import 'package:spa_scaffold/src/ui/text.dart';
import 'package:spa_scaffold/src/ui/theme.dart';
import 'package:spa_scaffold/src/ui/window.dart';

enum SpaQuestionDialogReturn {yes, no}

class SpaDialogs {
  static Future<void> showMessage(BuildContext context, String title, String message) async =>
    await _showDialog(context, true, _MessageDialog(title, message));

  static Future<SpaQuestionDialogReturn> showQuestion(
    BuildContext context, String title, String question
  ) async {
    SpaQuestionDialogReturn? r = await _showDialog<SpaQuestionDialogReturn>(
      context, false, _QuestionDialog(title, question)
    );
    return r ?? SpaQuestionDialogReturn.no;
  }

  static Future<T?> _showDialog<T>(BuildContext context, bool allowDismiss, Widget widget) async {
    final SpaTheme theme = context.read<SpaTheme>();
    return await showDialog<T>(
      context: context,
      useSafeArea: true,
      barrierDismissible: allowDismiss,
      barrierColor: theme.navigatorBackgroundColor,
      builder: allowDismiss
        ? (context) => widget
        : (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: widget
          );
        }
    );
  }
}

abstract class _BaseDialog extends StatelessWidget {
  static final EdgeInsets windowPaddings = EdgeInsets.all(36);
  static final EdgeInsets contentPaddings = EdgeInsets.all(16);
  static final EdgeInsets titleMargins = SpaWindow.parseMargins(0, 0, 0, -1);

  final IconData icon;
  final String title;

  _BaseDialog(this.icon, this.title);

  @override
  Widget build(BuildContext context) {
    final SpaSettingsModel sets = context.read<SpaSettingsModel>();

    final Widget titlePanel = SpaPanel(
      color: sets.theme.headerTheme.color,
      shadow: sets.hasHeadersShadow || sets.isFloatingPanels ? sets.theme.allShadows : null,
      margins: sets.isFloatingPanels ? titleMargins : null,
      borders: sets.isFloatingPanels ? SpaWindow.allBorders : null,
      child: Row(
        children: [
          Icon(
            icon, size: 30,
            color: sets.theme.headerTheme.iconButtonTheme.getIconColor(true)
          ),
          SpaSeparator(),
          Expanded(child: SpaText(title, sets.theme.headerTheme.titleStyle))
        ]
      )
    );

    final Widget contentPanel = SpaPanel(
      color: sets.theme.contentTheme.color,
      shadow: sets.theme.allShadows,
      borders: SpaWindow.allBorders,
      paddings: null,
      clip: true,
      child: Column(
        children: [
          if (! sets.isFloatingPanels)
            titlePanel,

          Padding(
            padding: contentPaddings,
            child: contentBuilder(context)
          ),
          SpaPanel(
            color: sets.theme.barTheme.color,
            child: barBuilder(context)
          )
        ]
      )
    );

    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: windowPaddings,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 380),
            child: sets.isFloatingPanels
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [titlePanel, contentPanel]
                )
              :
                contentPanel
          )
        )
      )
    );
  }

  @protected
  Widget contentBuilder(BuildContext context);

  @protected
  Widget barBuilder(BuildContext context);

  Widget _getIconText(BuildContext context, String text) {
    final SpaTheme theme = context.read<SpaTheme>();

    final Widget textWidget = SpaText(
      text, theme.contentTheme.subtitleStyle,
      allowWrap: true
    );

    if (context.screenWidth - windowPaddings.horizontal >= 240)
      return Row(
        children: [
          Icon(icon, size: 64, color: theme.contentTheme.iconButtonTheme.getIconColor(true)),
          SpaSeparator(2),
          Expanded(child: textWidget)
        ]
      );

    return textWidget;
  }
}

class _MessageDialog extends _BaseDialog {
  final String message;

  _MessageDialog(String title, this.message) : super(Icons.info, title);

  @override
  Widget contentBuilder(BuildContext context) => _getIconText(context, message);

  @override
  Widget barBuilder(BuildContext context) {
    final SpaTheme theme = context.read<SpaTheme>();
    final SpaStrings strings = context.read<SpaStrings>();

    return SpaTextButton(
      Icons.check, strings.ok, theme.barTheme.textButtonTheme,
      () => Navigator.of(context).pop(),
      expanded: false,
      borders: SpaWindow.allBorders
    );
  }
}

class _QuestionDialog extends _BaseDialog {
  final String question;

  _QuestionDialog(String title, this.question) : super(Icons.help, title);

  @override
  Widget contentBuilder(BuildContext context) => _getIconText(context, question);

  @override
  Widget barBuilder(BuildContext context) {
    final SpaTheme theme = context.read<SpaTheme>();
    final SpaStrings strings = context.read<SpaStrings>();

    final Widget yesButton = SpaTextButton(
      Icons.check, strings.yes, theme.barTheme.textButtonTheme,
      () => Navigator.of(context).pop(SpaQuestionDialogReturn.yes),
      expanded: false,
      borders: SpaWindow.allBorders
    );

    final Widget noButton = SpaTextButton(
      Icons.close, strings.no, theme.textButtonXBarTheme,
      () => Navigator.of(context).pop(SpaQuestionDialogReturn.no),
      expanded: false,
      borders: SpaWindow.allBorders
    );

    if (context.screenWidth - _BaseDialog.windowPaddings.horizontal >= 200) {
      return Row(
        children: [
          Expanded(child: yesButton),
          SpaSeparator(),
          Expanded(child: noButton)
        ]
      );
    }

    return Column(children: [yesButton, SpaSeparator(), noButton]);
  }
}