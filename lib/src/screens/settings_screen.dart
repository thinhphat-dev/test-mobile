import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../../main.dart';

class SettingsScreen extends PositionComponent with HasGameRef<AdvancedFightingGame> {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = Vector2(AdvancedFightingGame.virtualWidth, AdvancedFightingGame.virtualHeight);

    add(
      TextComponent(
        text: 'SETTINGS',
        position: Vector2(size.x / 2, 100),
        anchor: Anchor.center,
      ),
    );

    add(
      TextComponent(
        text: 'Music: ON',
        position: Vector2(size.x / 2, 250),
        anchor: Anchor.center,
      ),
    );

    add(
      TextComponent(
        text: 'SFX: ON',
        position: Vector2(size.x / 2, 300),
        anchor: Anchor.center,
      ),
    );

    add(
      TextComponent(
        text: 'Fullscreen: ACTIVE',
        position: Vector2(size.x / 2, 350),
        anchor: Anchor.center,
      ),
    );

    add(
      TextComponent(
        text: '[ BACK ]',
        position: Vector2(100, size.y - 50),
        anchor: Anchor.center,
      ),
    );
  }
}
