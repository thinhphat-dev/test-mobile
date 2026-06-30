import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import '../../main.dart';

class MainMenuScreen extends PositionComponent with HasGameRef<AdvancedFightingGame> {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = Vector2(AdvancedFightingGame.virtualWidth, AdvancedFightingGame.virtualHeight);

    // Tiêu đề game
    add(
      TextComponent(
        text: 'ANCIENT ARENA',
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Color(0xFF00E6FF),
            fontSize: 48,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          ),
        ),
        position: Vector2(size.x / 2, 180),
        anchor: Anchor.center,
      ),
    );

    // Nút Bắt đầu chơi
    add(
      MenuButton(
        'PLAY NOW',
        position: Vector2(size.x / 2, 380),
        onTap: () {
          gameRef.router.pushReplacementNamed('character-select');
        },
      ),
    );

    // Nút Cài đặt
    add(
      MenuButton(
        'SETTINGS',
        position: Vector2(size.x / 2, 460),
        onTap: () {
          gameRef.router.pushReplacementNamed('settings');
        },
      ),
    );
  }
}

/// Thành phần Nút bấm tùy chỉnh có hiệu ứng nhấn tương tác
class MenuButton extends PositionComponent with TapCallbacks {
  final String label;
  final VoidCallback onTap;

  MenuButton(
    this.label, {
    required Vector2 position,
    required this.onTap,
  }) : super(
          position: position,
          size: Vector2(260, 50),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Nền nút bấm
    add(
      RectangleComponent(
        size: size,
        paint: Paint()
          ..color = const Color(0xFF1a1a2e)
          ..style = PaintingStyle.fill,
      ),
    );

    // Khung viền nút bấm
    add(
      RectangleComponent(
        size: size,
        paint: Paint()
          ..color = const Color(0xFF00E6FF)
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke,
      ),
    );

    // Nhãn nút bấm
    add(
      TextComponent(
        text: label,
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        anchor: Anchor.center,
        position: size / 2,
      ),
    );
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    onTap();
  }
}
