import 'dart:ui';
import 'package:flame/components.dart';
import '../../main.dart';

class GameHUD extends PositionComponent with HasGameRef<AdvancedFightingGame> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    size = Vector2(gameRef.size.x, 60);
    
    // Khung máu Người chơi
    add(
      RectangleComponent(
        size: Vector2(300, 20),
        position: Vector2(20, 10),
        paint: Paint()..color = const Color(0xFF333333),
      ),
    );
    
    // Thanh máu xanh lá cây (Player)
    add(
      RectangleComponent(
        size: Vector2(280, 16),
        position: Vector2(30, 12),
        paint: Paint()..color = const Color(0xFF00FF00),
      ),
    );

    // Khung máu Bot đối thủ
    add(
      RectangleComponent(
        size: Vector2(300, 20),
        position: Vector2(size.x - 320, 10),
        paint: Paint()..color = const Color(0xFF333333),
      ),
    );
    
    // Thanh máu đỏ (Bot)
    add(
      RectangleComponent(
        size: Vector2(280, 16),
        position: Vector2(size.x - 310, 12),
        paint: Paint()..color = const Color(0xFFFF0000),
      ),
    );
  }
}
