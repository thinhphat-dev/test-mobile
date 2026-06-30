import 'dart:ui';
import 'package:flame/components.dart';
import 'base_character.dart';
import '../state/character_fsm.dart';
import '../state/character_state.dart';

class BotOpponent extends BaseCharacter {
  final BaseCharacter playerTarget;
  double _decisionCooldown = 0.0;

  BotOpponent({
    required super.position,
    required this.playerTarget,
  }) {
    speed = 200.0;
    fsm = CharacterFSM(character: this);
  }

  @override
  Color get characterColor => const Color(0xFFFF3366); // Đối thủ màu đỏ hồng

  @override
  void update(double dt) {
    super.update(dt);
    
    _decisionCooldown -= dt;
    if (_decisionCooldown <= 0) {
      _decisionCooldown = 0.25;
      _evaluateTacticalDecision();
    }
  }

  void _evaluateTacticalDecision() {
    // Nếu đối thủ đã chết, đứng im
    if (fsm.currentState == CharacterState.dead) return;

    final double distanceToPlayer = (playerTarget.position.x - position.x).abs();
    final double vertDistance = (playerTarget.position.y - position.y).abs();

    if (distanceToPlayer > 120.0 || vertDistance > 80.0) {
      fsm.transitionTo(CharacterState.walk);
      _moveTowardsPlayer();
    } else {
      // Tấn công người chơi
      fsm.transitionTo(CharacterState.lightAttack);
      playerTarget.takeDamage(1.5); // Gây sát thương nhẹ lên người chơi
    }
  }

  void _moveTowardsPlayer() {
    // Di chuyển theo trục X
    final double directionX = playerTarget.position.x > position.x ? 1.0 : -1.0;
    position.x += directionX * speed * 0.25;
    scale.x = directionX;

    // Di chuyển theo trục Y để bám đuổi theo chiều dọc
    final double vertDistance = (playerTarget.position.y - position.y).abs();
    if (vertDistance > 10.0) {
      final double directionY = playerTarget.position.y > position.y ? 1.0 : -1.0;
      position.y += directionY * speed * 0.25;
    }
  }
}
