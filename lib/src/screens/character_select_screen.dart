import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import 'main_menu_screen.dart';

class CharacterSelectScreen extends PositionComponent with HasGameRef<AdvancedFightingGame> {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = Vector2(AdvancedFightingGame.virtualWidth, AdvancedFightingGame.virtualHeight);

    // Tiêu đề
    add(
      TextComponent(
        text: 'LỰA CHỌN ĐẤU SĨ',
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Color(0xFF00E6FF),
            fontSize: 36,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
        position: Vector2(size.x / 2, 70),
        anchor: Anchor.center,
      ),
    );

    // Thẻ nhân vật Frost Mage
    add(
      CharacterCard(
        name: 'FROST MAGE',
        subtitle: 'Pháp sư Băng giá',
        speed: '190',
        hp: '100',
        skill: 'Tầm xa',
        color: const Color(0xFF0088FF),
        position: Vector2(size.x / 2 - 200, 160),
        onSelect: () {
          // TODO: Bắt đầu trận đấu với FrostMage
        },
      ),
    );

    // Thẻ nhân vật Blaze Fighter
    add(
      CharacterCard(
        name: 'BLAZE FIGHTER',
        subtitle: 'Đấu sĩ Lửa',
        speed: '260',
        hp: '100',
        skill: 'Cận chiến',
        color: const Color(0xFFFF4400),
        position: Vector2(size.x / 2 + 200, 160),
        onSelect: () {
          // TODO: Bắt đầu trận đấu với BlazeFighter
        },
      ),
    );

    // Nút quay lại
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

/// Thẻ nhân vật có thể bấm chọn
class CharacterCard extends PositionComponent with TapCallbacks {
  final String name;
  final String subtitle;
  final String speed;
  final String hp;
  final String skill;
  final Color color;
  final VoidCallback onSelect;

  CharacterCard({
    required this.name,
    required this.subtitle,
    required this.speed,
    required this.hp,
    required this.skill,
    required this.color,
    required Vector2 position,
    required this.onSelect,
  }) : super(
          position: position,
          size: Vector2(300, 420),
          anchor: Anchor.topCenter,
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Nền thẻ
    add(
      RectangleComponent(
        size: size,
        paint: Paint()
          ..color = const Color(0xFF12122a)
          ..style = PaintingStyle.fill,
      ),
    );

    // Viền thẻ
    add(
      RectangleComponent(
        size: size,
        paint: Paint()
          ..color = color
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke,
      ),
    );

    // Khung hình nhân vật (placeholder)
    add(
      RectangleComponent(
        position: Vector2(30, 20),
        size: Vector2(240, 180),
        paint: Paint()
          ..color = color.withOpacity(0.15)
          ..style = PaintingStyle.fill,
      ),
    );

    // Biểu tượng nhân vật đơn giản (hình tròn đầu + thân)
    add(
      CircleComponent(
        radius: 25,
        position: Vector2(150, 75),
        anchor: Anchor.center,
        paint: Paint()..color = color.withOpacity(0.7),
      ),
    );
    add(
      RectangleComponent(
        position: Vector2(135, 100),
        size: Vector2(30, 60),
        paint: Paint()..color = color.withOpacity(0.5),
      ),
    );

    // Tên nhân vật
    add(
      TextComponent(
        text: name,
        textRenderer: TextPaint(
          style: TextStyle(
            color: color,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        position: Vector2(size.x / 2, 220),
        anchor: Anchor.center,
      ),
    );

    // Phụ đề
    add(
      TextComponent(
        text: subtitle,
        textRenderer: TextPaint(
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 14,
          ),
        ),
        position: Vector2(size.x / 2, 248),
        anchor: Anchor.center,
      ),
    );

    // Đường kẻ phân cách
    add(
      RectangleComponent(
        position: Vector2(30, 270),
        size: Vector2(240, 1),
        paint: Paint()..color = color.withOpacity(0.3),
      ),
    );

    // Chỉ số HP
    add(
      TextComponent(
        text: '❤  HP: $hp',
        textRenderer: TextPaint(
          style: const TextStyle(color: Colors.white70, fontSize: 16),
        ),
        position: Vector2(40, 290),
      ),
    );

    // Chỉ số Speed
    add(
      TextComponent(
        text: '⚡  Speed: $speed',
        textRenderer: TextPaint(
          style: const TextStyle(color: Colors.white70, fontSize: 16),
        ),
        position: Vector2(40, 320),
      ),
    );

    // Loại kỹ năng
    add(
      TextComponent(
        text: '🎯  $skill',
        textRenderer: TextPaint(
          style: const TextStyle(color: Colors.white70, fontSize: 16),
        ),
        position: Vector2(40, 350),
      ),
    );

    // Nút chọn
    add(
      MenuButton(
        'CHỌN',
        position: Vector2(size.x / 2, size.y - 25),
        onTap: onSelect,
      ),
    );
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    onSelect();
  }
}

