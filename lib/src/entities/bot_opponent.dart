import 'package:flame/components.dart';
import 'base_character.dart';
import '../state/character_fsm.dart';
import '../state/character_state.dart';

class BotOpponent extends BaseCharacter {
  final BaseCharacter playerTarget;
  late final CharacterFSM fsm;
  double _decisionCooldown = 0.0;

  BotOpponent({
    required super.position,
    required this.playerTarget,
  }) {
    speed = 200.0;
    fsm = CharacterFSM(character: this);
  }

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
    final double distanceToPlayer = (playerTarget.position.x - position.x).abs();

    if (distanceToPlayer > 300.0) {
      fsm.transitionTo(CharacterState.walk);
      _moveTowardsPlayer();
    } else if (distanceToPlayer <= 100.0) {
      fsm.transitionTo(CharacterState.lightAttack);
    } else {
      fsm.transitionTo(CharacterState.idle);
    }
  }

  void _moveTowardsPlayer() {
    final double direction = playerTarget.position.x > position.x ? 1.0 : -1.0;
    position.x += direction * speed * 0.25;
    scale.x = direction;
  }
}
