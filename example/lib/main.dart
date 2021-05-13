import 'dart:ui';

import 'package:example/pages/home_page.dart';
import 'package:example/pages/main_menu.dart';
import 'package:example/ui/strings.dart';
import 'package:example/ui/themes.dart';
import 'package:provider/provider.dart';
import 'package:spa_scaffold/spa_scaffold.dart';

void main() {
  spaRun(
    (context) {
      final AppStrings strings = context.read<SpaSettingsModel>().appStrings;
      return [strings.blueGrey, strings.blueGreyDark];
    },
    (themeIndex) {
      if (themeIndex == 0)
        return BlueGreyTheme();
      return BlueGreyDarkTheme();
    },

    (context) {
      final AppStrings strings = context.read<SpaSettingsModel>().appStrings;
      return [strings.english, strings.portuguese];
    },
    (languageIndex) {
      if (languageIndex == 0)
        return AppStrings(Locale('en'));
      return AppStrings(Locale('pt'));
    },

    () => HomePage(),
    getMainMenu
  );
}