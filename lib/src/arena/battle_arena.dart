import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'dart:ui';

class BattleArena extends World {
  final double arenaWidth = 2400.0;
  final double arenaHeight = 720.0;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final background = SpriteComponent()
      ..size = Vector2(arenaWidth, arenaHeight);
    add(background);
  }
}
