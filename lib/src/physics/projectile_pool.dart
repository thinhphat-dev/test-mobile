import 'package:flame/components.dart';
import '../entities/base_character.dart';

class IceSpellProjectile extends PositionComponent with CollisionCallbacks {
  final BaseCharacter creator;
  double activeTime = 0.0;

  IceSpellProjectile({required this.creator}) : super(size: Vector2(30, 15));

  void resetState(Vector2 newPosition, double direction) {
    position = newPosition;
    scale.x = direction;
    activeTime = 0.0;
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x += scale.x * 450.0 * dt;
    activeTime += dt;
    
    if (activeTime > 2.5) {
      removeFromParent();
    }
  }
}
