import 'package:flame/components.dart';
import '../../main.dart';

class GameHUD extends PositionComponent {
  GameHUD() : super(size: Vector2(AdvancedFightingGame.virtualWidth, 60));

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    add(
      RectangleComponent(
        size: Vector2(300, 20),
        position: Vector2(20, 10),
        paint: Paint()..color = const Color(0xFF333333),
      ),
    );
    
    add(
      RectangleComponent(
        size: Vector2(280, 16),
        position: Vector2(30, 12),
        paint: Paint()..color = const Color(0xFF00FF00),
      ),
    );

    add(
      RectangleComponent(
        size: Vector2(300, 20),
        position: Vector2(AdvancedFightingGame.virtualWidth - 320, 10),
        paint: Paint()..color = const Color(0xFF333333),
      ),
    );
    
    add(
      RectangleComponent(
        size: Vector2(280, 16),
        position: Vector2(AdvancedFightingGame.virtualWidth - 310, 12),
        paint: Paint()..color = const Color(0xFFFF0000),
      ),
    );
  }
}
