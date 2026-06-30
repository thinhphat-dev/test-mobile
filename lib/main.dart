import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'src/game_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  final game = AdvancedFightingGame();
  runApp(
    GameWidget(
      game: game,
    ),
  );
}

class AdvancedFightingGame extends FlameGame with GameRouter {
  static const double virtualWidth = 1280.0;
  static const double virtualHeight = 720.0;

  @override
  Color backgroundColor() => const Color(0xFF09090E);
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await router.load();
  }
}
