import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa_scaffold/src/page/settings_model.dart';
import 'package:spa_scaffold/src/ui/button.dart';
import 'package:spa_scaffold/src/ui/panel.dart';
import 'package:spa_scaffold/src/ui/scroll_view.dart';
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
  static final double maxWidth = 380;
  static final EdgeInsets titleMargins = SpaWin.parseMargins(0, 0, 0, -1);

  final IconData icon;
  final String title;

  _BaseDialog(this.icon, this.title);

  @override
  Widget build(BuildContext context) {
    final SpaSettingsModel sets = context.read<SpaSettingsModel>();

    final Widget titlePanel = SpaPanel(
      width: maxWidth,
      color: sets.theme.headerTheme.color,
      shadow: sets.hasHeadersShadow || sets.isFloatingPanels ? sets.theme.allShadows : null,
      margins: sets.isFloatingPanels ? titleMargins : null,
      borders: sets.isFloatingPanels ? SpaWin.allBorders : null,
      child: Row(
        children: [
          Icon(
            icon, size: 30,
            color: sets.theme.headerTheme.iconButtonTheme.getIconColor(true)
          ),
          SpaSep.sep8,
          Expanded(child: SpaText(title, sets.theme.headerTheme.titleStyle))
        ]
      )
    );

    final Widget contentPanel = SpaPanel(
      width: maxWidth,
      color: sets.theme.contentTheme.color,
      shadow: sets.theme.allShadows,
      borders: SpaWin.allBorders,
      paddings: null,
      clip: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (! sets.isFloatingPanels)
            titlePanel,

          Flexible(
            child: Padding(
              padding: SpaWin.edgeInsets16,
              child: contentBuilder(context)
            )
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
        padding: SpaWin.edgeInsets32,
        child: Center(
          child: sets.isFloatingPanels
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  titlePanel,
                  Flexible(child: contentPanel)
                ]
              )
            :
              contentPanel
        )
      )
    );
  }

  @protected
  Widget contentBuilder(BuildContext context);

  @protected
  Widget barBuilder(BuildContext context);
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String text;

  _IconText(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    final SpaTheme theme = context.read<SpaTheme>();

    final Widget textWidget = SpaScrollView(
      theme.contentTheme.scrollbarColor,
      SpaText(
        text, theme.contentTheme.subtitleStyle,
        allowWrap: true
      )
    );

    if (context.screenWidth - SpaWin.edgeInsets32.horizontal >= 240) {
      return Row(
        children: [
          Icon(icon, size: 64, color: theme.contentTheme.iconButtonTheme.getIconColor(true)),
          SpaSep.sep16,
          Expanded(child: textWidget)
        ]
      );
    }

    return textWidget;
  }
}

class _MessageDialog extends _BaseDialog {
  final String message;

  _MessageDialog(String title, this.message) : super(Icons.info, title);

  @override
  Widget contentBuilder(BuildContext context) => _IconText(icon, message);

  @override
  Widget barBuilder(BuildContext context) {
    final SpaTheme theme = context.read<SpaTheme>();
    final SpaStrings strings = context.read<SpaStrings>();

    return SpaTextButton(
      Icons.check, strings.ok, theme.barTheme.textButtonTheme,
      () => Navigator.of(context).pop(),
      expanded: false,
      borders: SpaWin.allBorders
    );
  }
}

class _QuestionDialog extends _BaseDialog {
  final String question;

  _QuestionDialog(String title, this.question) : super(Icons.help, title);

  @override
  Widget contentBuilder(BuildContext context) => _IconText(icon, question);

  @override
  Widget barBuilder(BuildContext context) {
    final SpaTheme theme = context.read<SpaTheme>();
    final SpaStrings strings = context.read<SpaStrings>();

    final Widget yesButton = SpaTextButton(
      Icons.check, strings.yes, theme.barTheme.textButtonTheme,
      () => Navigator.of(context).pop(SpaQuestionDialogReturn.yes),
      expanded: false,
      borders: SpaWin.allBorders
    );

    final Widget noButton = SpaTextButton(
      Icons.close, strings.no, theme.textButtonXBarTheme,
      () => Navigator.of(context).pop(SpaQuestionDialogReturn.no),
      expanded: false,
      borders: SpaWin.allBorders
    );

    if (context.screenWidth - SpaWin.edgeInsets32.horizontal >= 200) {
      return Row(
        children: [
          Expanded(child: yesButton),
          SpaSep.sep8,
          Expanded(child: noButton)
        ]
      );
    }

    return Column(
      children: [
        yesButton,
        SpaSep.sep8,
        noButton
      ]
    );
  }
}