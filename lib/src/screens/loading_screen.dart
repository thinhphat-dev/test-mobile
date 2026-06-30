import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../../main.dart';

class LoadingScreen extends PositionComponent with HasGameRef<AdvancedFightingGame> {
  late final TextComponent _percentageText;
  double _progress = 0.0;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = Vector2(AdvancedFightingGame.virtualWidth, AdvancedFightingGame.virtualHeight);
    
    _percentageText = TextComponent(
      text: 'ĐANG NẠP TÀI NGUYÊN: 0%',
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      position: Vector2(size.x / 2, size.y / 2),
      anchor: Anchor.center,
    );
    add(_percentageText);

    _preloadAssets();
  }

  Future<void> _preloadAssets() async {
    for (int i = 1; i <= 10; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      _progress = i / 10.0;
      _percentageText.text = 'ĐANG NẠP TÀI NGUYÊN: ${(_progress * 100).toInt()}%';
    }
    gameRef.router.pushReplacementNamed('menu');
  }
}

