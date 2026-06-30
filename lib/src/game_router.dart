import 'package:flame/components.dart';
import 'package:flame/game.dart';
import '../main.dart';
import 'screens/loading_screen.dart';
import 'screens/main_menu_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/character_select_screen.dart';

class GameRouter extends RouterComponent {
  GameRouter()
      : super(
          initialRoute: 'loading',
          routes: {
            'loading': Route(LoadingScreen.new),
            'menu': Route(MainMenuScreen.new),
            'settings': Route(SettingsScreen.new),
            'character-select': Route(CharacterSelectScreen.new),
          },
        );
}
