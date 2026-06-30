import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import 'main_menu_screen.dart';

class SettingsScreen extends PositionComponent with HasGameRef<AdvancedFightingGame> {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = gameRef.size;

    add(
      TextComponent(
        text: 'SETTINGS',
        position: Vector2(size.x / 2, size.y * 0.15),
        anchor: Anchor.center,
      ),
    );

    add(
      TextComponent(
        text: 'Music: ON',
        position: Vector2(size.x / 2, size.y * 0.35),
        anchor: Anchor.center,
      ),
    );

    add(
      TextComponent(
        text: 'SFX: ON',
        position: Vector2(size.x / 2, size.y * 0.45),
        anchor: Anchor.center,
      ),
    );

    add(
      TextComponent(
        text: 'Fullscreen: ACTIVE',
        position: Vector2(size.x / 2, size.y * 0.55),
        anchor: Anchor.center,
      ),
    );

    add(
      MenuButton(
        'BACK',
        position: Vector2(150, size.y - 60),
        onTap: () {
          gameRef.router.pushReplacementNamed('menu');
        },
      ),
    );
  }
}
