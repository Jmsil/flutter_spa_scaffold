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
    THM Function() themeBuilder,
    SpaPage Function() homePageBuilder,
    SpaMainMenuGroup Function(STR) mainMenuItemsBuilder
  )
{
  final STR providedStrings = stringsBuilder(Locale('en'));
  final THM providedTheme = themeBuilder();

  runApp(
    MultiProvider(
      providers: [
        Provider<STR>.value(value: providedStrings),
        Provider<SpaStrings>.value(value: providedStrings),
        Provider<THM>.value(value: providedTheme),
        Provider<SpaTheme>.value(value: providedTheme),
        ChangeNotifierProvider<PagesControllerModel>(
          create: (context) => PagesControllerModel(homePageBuilder())
        ),
        ChangeNotifierProvider<MainMenuModel>(
          create: (context) => MainMenuModel(mainMenuItemsBuilder(providedStrings))
        ),
        ChangeNotifierProvider<SpaSettingsModel>(
          create: (context) => SpaSettingsModel(true, true, true)
        )
      ],
      builder: (context, child) {
        final SpaTheme theme = context.read<SpaTheme>();
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
              color: theme.homeBackgroundColor,
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