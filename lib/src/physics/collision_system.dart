import 'package:flame/game.dart';
import 'package:flame/collisions.dart';

mixin GameCollisionManager on FlameGame with HasCollisionDetection {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    collisionDetection = StandardCollisionDetection();
  }
}
