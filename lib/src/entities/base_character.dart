import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import '../../main.dart';

abstract class BaseCharacter extends PositionComponent with CollisionCallbacks, HasGameRef<AdvancedFightingGame> {
  double hp = 100.0;
  double maxHp = 100.0;
  double speed = 220.0;
  int facingDirection = 1;

  BaseCharacter({
    required Vector2 position,
  }) : super(
          position: position,
          size: Vector2(120, 180),
          anchor: Anchor.bottomCenter,
        );
}
