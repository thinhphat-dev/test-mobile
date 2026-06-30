import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../../main.dart';

class MainMenuScreen extends PositionComponent with HasGameRef<AdvancedFightingGame> {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = Vector2(AdvancedFightingGame.virtualWidth, AdvancedFightingGame.virtualHeight);

    add(
      TextComponent(
        text: 'ANCIENT ARENA',
        position: Vector2(size.x / 2, 180),
        anchor: Anchor.center,
      ),
    );
  }
}
