import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa_scaffold/src/page/page.dart';
import 'package:spa_scaffold/src/page/settings_page/settings_model.dart';
import 'package:spa_scaffold/src/ui/scroll_view.dart';
import 'package:spa_scaffold/src/ui/selector.dart';
import 'package:spa_scaffold/src/ui/separator.dart';
import 'package:spa_scaffold/src/ui/strings.dart';
import 'package:spa_scaffold/src/ui/text.dart';

class SettingsPage extends SpaPage {
  SettingsPage(IconData icon) : super(icon);

  @override
  String getTitle(SpaStrings strings) => strings.userPreferences;

  @override
  Widget contentBuilder(BuildContext context) {
    final SpaSettingsModel mSets = context.watch<SpaSettingsModel>();
    int themeRadioIdx = 0;
    int languageRadioIdx = 0;

    return Center(
      child: SpaScrollView(
        mSets.theme.contentTheme.scrollbarColor,
        Table(
          defaultColumnWidth: IntrinsicColumnWidth(),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [

            // Theme
            TableRow(
              children: [
                SpaText(mSets.strings.theme, mSets.theme.contentTheme.titleStyle), SpaSep.sep0
              ]
            ),
            TableRow(
              children: [
                SpaSep.sep8, SpaSep.sep0
              ]
            ),

            for (String themeName in mSets.getThemesList(context))
              TableRow(
                children: [
                  SpaText(themeName, mSets.theme.contentTheme.subtitleStyle),
                  SpaRadio(
                    themeRadioIdx++, mSets.themeIndex, mSets.theme.contentTheme.radioTheme,
                    mSets.setTheme
                  )
                ]
              ),

            TableRow(
              children: [
                SpaSep.sep24, SpaSep.sep0
              ]
            ),


            // Language
            TableRow(
              children: [
                SpaText(mSets.strings.language, mSets.theme.contentTheme.titleStyle), SpaSep.sep0
              ]
            ),
            TableRow(
              children: [
                SpaSep.sep8, SpaSep.sep0
              ]
            ),

            for (String languageName in mSets.getLanguagesList(context))
              TableRow(
                children: [
                  SpaText(languageName, mSets.theme.contentTheme.subtitleStyle),
                  SpaRadio(
                    languageRadioIdx++, mSets.languageIndex, mSets.theme.contentTheme.radioTheme,
                    mSets.setLanguage
                  )
                ]
              ),

            TableRow(
              children: [
                SpaSep.sep24, SpaSep.sep0
              ]
            ),


            // Window
            TableRow(
              children: [
                SpaText(mSets.strings.floatingPanels, mSets.theme.contentTheme.subtitleStyle),
                SpaSwitch(
                  mSets.isFloatingPanels, mSets.theme.contentTheme.switchTheme,
                  mSets.setIsFloatingPanels
                )
              ]
            ),
            TableRow(
              children: [
                SpaText(mSets.strings.headersShadow, mSets.theme.contentTheme.subtitleStyle),
                SpaSwitch(
                  mSets.hasHeadersShadow, mSets.theme.contentTheme.switchTheme,
                  mSets.setHasHeadersShadow
                )
              ]
            ),
            TableRow(
              children: [
                SpaText(mSets.strings.panelsDecorImage, mSets.theme.contentTheme.subtitleStyle),
                SpaSwitch(
                  mSets.hasPanelsDecorImage, mSets.theme.contentTheme.switchTheme,
                  mSets.setHasPanelsDecorImage
                )
              ]
            )
          ]
        )
      )
    );
  }
}