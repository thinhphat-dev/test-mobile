import 'dart:ui';
import 'package:flame/components.dart';
import 'base_character.dart';
import 'bot_opponent.dart';
import '../state/character_fsm.dart';
import '../state/character_state.dart';

class Player extends BaseCharacter {
  final JoystickComponent joystick;

  Player({
    required super.position,
    required this.joystick,
  }) {
    speed = 240.0;
    fsm = CharacterFSM(character: this);
  }

  @override
  Color get characterColor => const Color(0xFF00FF66); // Đấu sĩ chính màu xanh lá cây

  @override
  void update(double dt) {
    super.update(dt);

    // Di chuyển đấu sĩ dựa trên hướng joystick
    if (!joystick.delta.isZero()) {
      position.add(joystick.relativeDelta * speed * dt);
      
      // Lật hướng hình vẽ dựa trên hướng di chuyển ngang
      if (joystick.relativeDelta.x < 0) {
        scale.x = -1;
      } else if (joystick.relativeDelta.x > 0) {
        scale.x = 1;
      }
      fsm.transitionTo(CharacterState.walk);
    } else {
      // Nếu không bấm phím và không trong trạng thái tấn công/trúng đòn, chuyển về idle
      if (fsm.currentState == CharacterState.walk) {
        fsm.transitionTo(CharacterState.idle);
      }
    }

    // Gây sát thương lên Bot nếu đang tấn công gần đối thủ
    if (fsm.currentState == CharacterState.lightAttack || fsm.currentState == CharacterState.heavyAttack) {
      final opponents = gameRef.world.children.whereType<BotOpponent>();
      for (final bot in opponents) {
        final distance = (position.x - bot.position.x).abs();
        final vertDistance = (position.y - bot.position.y).abs();
        if (distance < 130.0 && vertDistance < 100.0) {
          bot.takeDamage(fsm.currentState == CharacterState.lightAttack ? 1.0 : 3.0); // gây dame liên tục mỗi frame khi trúng
        }
      }
    }
  }
}
