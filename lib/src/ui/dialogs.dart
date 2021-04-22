import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa_scaffold/src/ui/panel.dart';
import 'package:spa_scaffold/src/ui/theme.dart';
import 'package:spa_scaffold/src/ui/window.dart';
import 'package:spa_scaffold/src/ui/button.dart';
import 'package:spa_scaffold/src/ui/text.dart';

class SpaDialogs {
  static void showMessage(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: false,
      builder: (context) => _OkDialog('')
    );
  }

  static void showOkCancel(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: false,
      builder: (context) => _OkCancelDialog('')
    );
  }

  static void showYesNo(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: false,
      builder: (context) => _YesNoDialog('')
    );
  }
}

class _BaseDialog extends StatelessWidget {
  static final BorderRadius _barBorders = SpaWindow.parseBorders(0, 0, -1, -1);

  final String _title;

  _BaseDialog(this._title);

  @override
  Widget build(BuildContext context) {
    final SpaTheme theme = context.read<SpaTheme>();

    return Dialog(
      backgroundColor: theme.contentPanelColor,
      //insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: SpaWindow.allBorders),
      child: Column(
        children: [
          //SpaText(_title, theme.)
          SpaPanel(
            color: theme.barPanelColor,
            //margins: SpaWindow.allMargins,
            borders: _barBorders,
            child: SpaTextButton(
              Icons.close, 'Close', theme.textButtonBarTheme,
              () => Navigator.of(context).pop()
            )
          )
        ]
      )
    );
  }

  @protected
  Widget contentBuilder(BuildContext context) {
    return Center();
  }

  @protected barBuilder(BuildContext context) {
    return Center();
  }
}

class _OkDialog extends _BaseDialog {
  _OkDialog(String title) : super(title);
}

class _OkCancelDialog extends _BaseDialog {
  _OkCancelDialog(String title) : super(title);
}

class _YesNoDialog extends _BaseDialog {
  _YesNoDialog(String title) : super(title);
}