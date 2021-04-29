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
    return await showDialog<T>(
      context: context,
      useSafeArea: true,
      barrierDismissible: allowDismiss,
      barrierColor: context.read<SpaTheme>().navigatorBackgroundColor,
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
    final SpaTheme theme = context.read<SpaTheme>();
    final SpaStrings strings = context.read<SpaStrings>();
    final SpaSettingsModel settings = context.read<SpaSettingsModel>();

    final Widget titlePanel = SpaPanel(
      color: theme.headerTheme.color,
      shadow: settings.hasHeaderShadow || settings.isFloatingPanel ? theme.allShadows : null,
      margins: settings.isFloatingPanel ? titleMargins : null,
      borders: settings.isFloatingPanel ? SpaWindow.allBorders : null,
      child: Row(
        children: [
          Icon(
            icon, size: 30,
            color: theme.headerTheme.iconButtonTheme.getIconColor(true)
          ),
          SpaSeparator(),
          Expanded(child: SpaText(title, theme.headerTheme.titleStyle))
        ]
      )
    );

    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: windowPaddings,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 420),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (settings.isFloatingPanel)
                  titlePanel,

                SpaPanel(
                  color: theme.contentTheme.color,
                  shadow: theme.allShadows,
                  borders: SpaWindow.allBorders,
                  paddings: null,
                  clip: true,
                  child: Column(
                    children: [
                      if (! settings.isFloatingPanel)
                        titlePanel,

                      Padding(
                        padding: contentPaddings,
                        child: contentBuilder(context, theme)
                      ),
                      SpaPanel(
                        color: theme.barTheme.color,
                        child: barBuilder(context, theme, strings)
                      )
                    ]
                  )
                )
              ]
            )
          )
        )
      )
    );
  }

  @protected
  Widget contentBuilder(BuildContext context, SpaTheme theme);

  @protected
  Widget barBuilder(BuildContext context, SpaTheme theme, SpaStrings strings);

  Widget _getIconText(BuildContext context, SpaTheme theme, String text) {
    final Widget textWidget = SpaText(text, theme.contentTheme.titleStyle, true);

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
  Widget contentBuilder(BuildContext context, SpaTheme theme) =>
    _getIconText(context, theme, message);

  @override
  Widget barBuilder(BuildContext context, SpaTheme theme, SpaStrings strings) {
    return SpaTextButton(
      Icons.check, strings.ok, context.read<SpaTheme>().barTheme.textButtonTheme,
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
  Widget contentBuilder(BuildContext context, SpaTheme theme) =>
    _getIconText(context, theme, question);

  @override
  Widget barBuilder(BuildContext context, SpaTheme theme, SpaStrings strings) {
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