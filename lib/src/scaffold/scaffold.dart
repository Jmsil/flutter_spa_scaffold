import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa_scaffold/src/page/page.dart';
import 'package:spa_scaffold/src/page/settings_page/settings_model.dart';
import 'package:spa_scaffold/src/scaffold/main_menu.dart';
import 'package:spa_scaffold/src/scaffold/main_menu_model.dart';
import 'package:spa_scaffold/src/scaffold/main_menu_widget.dart';
import 'package:spa_scaffold/src/scaffold/pages_controller_model.dart';
import 'package:spa_scaffold/src/scaffold/pages_controller_widget.dart';
import 'package:spa_scaffold/src/ui/scroll_view.dart';
import 'package:spa_scaffold/src/ui/strings.dart';
import 'package:spa_scaffold/src/ui/theme.dart';

void spaRun(
    List<String> Function(BuildContext) themesListBuilder,
    SpaTheme Function(int) themeBuilder,
    List<String> Function(BuildContext) languagesListBuilder,
    SpaStrings Function(int) languageBuilder,
    SpaPage Function() homePageBuilder,
    SpaMainMenuGroup Function(BuildContext) mainMenuBuilder
  )
{
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SpaSettingsModel>(
          create: (_) => SpaSettingsModel(
            themesListBuilder, themeBuilder, 1,
            languagesListBuilder, languageBuilder, 0,
            true, true, true
          )
        ),
        ChangeNotifierProvider<PagesControllerModel>(
          create: (_) => PagesControllerModel(homePageBuilder())
        ),
        ChangeNotifierProxyProvider<SpaSettingsModel, MainMenuModel>(
          create: (context) => MainMenuModel(mainMenuBuilder(context)),
          update: (context, _, __) => MainMenuModel(mainMenuBuilder(context))
        )
      ],
      builder: (context, child) {
        final SpaSettingsModel mSets = context.watch<SpaSettingsModel>();
        final mainMenuKey = GlobalKey<DrawerControllerState>();

        return MaterialApp(
          title: mSets.strings.appName,
          scrollBehavior: SpaScrollBehavior(),
          home: SafeArea(
            child: Material(
              color: mSets.theme.contentTheme.color,
              child: Stack(
                children: [
                  PagesControllerWidget(mainMenuKey),
                  MainMenuWidget(mainMenuKey)
                ]
              )
            )
          ),
          debugShowCheckedModeBanner: false
        );
      }
    )
  );
}