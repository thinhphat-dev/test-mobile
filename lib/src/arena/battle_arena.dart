import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'dart:ui';

class BattleArena extends World {
  final double arenaWidth = 2400.0;
  final double arenaHeight = 720.0;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    
    // Nền tối cho đấu trường
    final background = RectangleComponent(
      size: Vector2(arenaWidth, arenaHeight),
      paint: Paint()..color = const Color(0xFF0e0e1b),
    );
    add(background);

    // Vẽ vạch ngăn cách sàn đấu
    for (double x = 150; x < arenaWidth; x += 300) {
      add(
        RectangleComponent(
          position: Vector2(x, arenaHeight - 80),
          size: Vector2(4, 60),
          paint: Paint()..color = const Color(0xFF1a1a36),
        ),
      );
    }

    // Vẽ mặt đất của đấu trường
    final ground = RectangleComponent(
      position: Vector2(0, arenaHeight - 20),
      size: Vector2(arenaWidth, 20),
      paint: Paint()..color = const Color(0xFF00E6FF).withOpacity(0.4),
    );
    add(ground);
  }
}
