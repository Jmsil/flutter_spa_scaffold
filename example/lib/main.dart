import 'package:example/pages/home_page.dart';
import 'package:example/pages/main_menu.dart';
import 'package:example/ui/strings.dart';
import 'package:example/ui/themes.dart';
import 'package:spa_scaffold/spa_scaffold.dart';

void main() {
  spaRun<Strings, AppTheme>(
    (locale) => Strings(locale),
    () => BlueGreyTheme(),
    () => HomePage(),
    getMainMenuItems
  );
}