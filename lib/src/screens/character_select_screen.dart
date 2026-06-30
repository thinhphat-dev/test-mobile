import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../../main.dart';

class CharacterSelectScreen extends PositionComponent with HasGameRef<AdvancedFightingGame> {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = Vector2(AdvancedFightingGame.virtualWidth, AdvancedFightingGame.virtualHeight);

    add(
      TextComponent(
        text: 'LỰA CHỌN ĐẤU SĨ',
        position: Vector2(size.x / 2, 80),
        anchor: Anchor.center,
      ),
    );
  }
}
