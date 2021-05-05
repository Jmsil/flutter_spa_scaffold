import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spa_scaffold/src/page/page.dart';
import 'package:spa_scaffold/src/page/settings_model.dart';
import 'package:spa_scaffold/src/scaffold/main_menu_item.dart';
import 'package:spa_scaffold/src/scaffold/main_menu_model.dart';
import 'package:spa_scaffold/src/scaffold/main_menu_widget.dart';
import 'package:spa_scaffold/src/scaffold/pages_controller_model.dart';
import 'package:spa_scaffold/src/scaffold/pages_controller_widget.dart';
import 'package:spa_scaffold/src/ui/strings.dart';
import 'package:spa_scaffold/src/ui/theme.dart';

void spaRun<STR extends SpaStrings, THM extends SpaTheme>(
    STR Function(Locale) stringsBuilder,
    List<String> themesList,
    THM Function(int) themeBuilder,
    SpaPage Function() homePageBuilder,
    SpaMainMenuGroup Function(STR) mainMenuBuilder
  )
{
  final STR providedStrings = stringsBuilder(Locale('en'));

  runApp(
    MultiProvider(
      providers: [
        Provider<SpaStrings>.value(value: providedStrings),
        Provider<STR>.value(value: providedStrings),
        ChangeNotifierProvider<SpaSettingsModel>(
          create: (context) => SpaSettingsModel(true, true, true, themesList, themeBuilder, 1)
        ),
        ProxyProvider<SpaSettingsModel, SpaTheme>(update: (_, sets, __) => sets.theme),
        ProxyProvider<SpaSettingsModel, THM>(update: (_, sets, __) => sets.theme as THM),
        ChangeNotifierProvider<PagesControllerModel>(
          create: (context) => PagesControllerModel(homePageBuilder())
        ),
        ChangeNotifierProvider<MainMenuModel>(
          create: (context) => MainMenuModel(mainMenuBuilder(providedStrings))
        )
      ],
      builder: (context, child) {
        final SpaTheme theme = context.watch<SpaTheme>();
        final SpaStrings strings = context.read<SpaStrings>();
        final GlobalKey<DrawerControllerState> mainMenuKey = GlobalKey();

        return MaterialApp(
          title: strings.appName,
          theme: ThemeData(
            scrollbarTheme: ScrollbarThemeData(
              thumbColor: MaterialStateProperty.all(theme.scrollbarColor)
            )
          ),
          home: SafeArea(
            child: Material(
              color: theme.contentTheme.color,
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