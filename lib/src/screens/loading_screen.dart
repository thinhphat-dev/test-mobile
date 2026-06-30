import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../../main.dart';

class LoadingScreen extends Component with HasGameRef<AdvancedFightingGame> {
  late final TextComponent _percentageText;
  double _progress = 0.0;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    
    _percentageText = TextComponent(
      text: 'ĐANG NẠP TÀI NGUYÊN: 0%',
      position: Vector2(AdvancedFightingGame.virtualWidth / 2, AdvancedFightingGame.virtualHeight / 2),
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
