import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa_scaffold/src/page/settings_model.dart';
import 'package:spa_scaffold/src/ui/button.dart';
import 'package:spa_scaffold/src/ui/panel.dart';
import 'package:spa_scaffold/src/ui/scroll_view.dart';
import 'package:spa_scaffold/src/ui/separator.dart';
import 'package:spa_scaffold/src/ui/text.dart';
import 'package:spa_scaffold/src/ui/theme.dart';
import 'package:spa_scaffold/src/ui/window.dart';

enum SpaQuestionDialogReturn {yes, no}

class SpaDialogs {
  static Future<void> showMessage(BuildContext context, String title, String message) async =>
    await _showDialog(context, true, (_) => _MessageDialog(title, message));

  static Future<SpaQuestionDialogReturn> showQuestion(
      BuildContext context, String title, String question
    ) async
  {
    SpaQuestionDialogReturn? r = await _showDialog<SpaQuestionDialogReturn>(
      context, false, (_) => _QuestionDialog(title, question)
    );
    return r ?? SpaQuestionDialogReturn.no;
  }

  static Future<T?> _showDialog<T>(
      BuildContext context, bool allowDismiss, Widget Function(BuildContext) widgetBuilder
    ) async
  {
    final SpaTheme theme = context.read<SpaSettingsModel>().theme;
    return await showDialog<T>(
      context: context,
      useSafeArea: true,
      barrierDismissible: allowDismiss,
      barrierColor: theme.navigatorBackgroundColor,
      builder: allowDismiss
        ? widgetBuilder
        : (context) {
            return WillPopScope(
              onWillPop: () async => false,
              child: widgetBuilder(context)
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
    final SpaSettingsModel mSets = context.read<SpaSettingsModel>();

    final Widget titlePanel = SpaPanel(
      width: maxWidth,
      color: mSets.theme.headerTheme.color,
      shadow: mSets.hasHeadersShadow || mSets.isFloatingPanels ? mSets.theme.allShadows : null,
      margins: mSets.isFloatingPanels ? titleMargins : null,
      borders: mSets.isFloatingPanels ? SpaWin.allBorders : null,
      child: Row(
        children: [
          Icon(
            icon, size: 30,
            color: mSets.theme.headerTheme.iconButtonTheme.getIconColor(true)
          ),
          SpaSep.sep8,
          Expanded(child: SpaText(title, mSets.theme.headerTheme.titleStyle))
        ]
      )
    );

    final Widget contentPanel = SpaPanel(
      width: maxWidth,
      color: mSets.theme.contentTheme.color,
      shadow: mSets.theme.allShadows,
      borders: SpaWin.allBorders,
      paddings: null,
      clip: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (! mSets.isFloatingPanels)
            titlePanel,

          Flexible(
            child: Padding(
              padding: SpaWin.edgeInsets16,
              child: contentBuilder(context)
            )
          ),
          SpaPanel(
            color: mSets.theme.barTheme.color,
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
          child: mSets.isFloatingPanels
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
    final SpaRegionTheme theme = context.read<SpaSettingsModel>().theme.contentTheme;

    final Widget textWidget = SpaScrollView(
      theme.scrollbarColor,
      SpaText(
        text, theme.subtitleStyle,
        allowWrap: true
      )
    );

    if (context.screenWidth - SpaWin.edgeInsets32.horizontal >= 240) {
      return Row(
        children: [
          Icon(icon, size: 64, color: theme.iconButtonTheme.getIconColor(true)),
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
    final SpaSettingsModel mSets = context.read<SpaSettingsModel>();
    return SpaTextButton(
      Icons.check, mSets.strings.ok, mSets.theme.barTheme.textButtonTheme,
      () => Navigator.of(context).pop(),
      isCenter: true,
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
    final SpaSettingsModel mSets = context.read<SpaSettingsModel>();

    final Widget yesButton = SpaTextButton(
      Icons.check, mSets.strings.yes, mSets.theme.barTheme.textButtonTheme,
      () => Navigator.of(context).pop(SpaQuestionDialogReturn.yes),
      isCenter: true,
      borders: SpaWin.allBorders
    );

    final Widget noButton = SpaTextButton(
      Icons.close, mSets.strings.no, mSets.theme.textButtonXBarTheme,
      () => Navigator.of(context).pop(SpaQuestionDialogReturn.no),
      isCenter: true,
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        yesButton,
        SpaSep.sep8,
        noButton
      ]
    );
  }
}