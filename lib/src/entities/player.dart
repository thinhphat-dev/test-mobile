import 'package:flame/components.dart';
import 'base_character.dart';
import '../state/character_fsm.dart';

class Player extends BaseCharacter {
  late final CharacterFSM fsm;

  Player({required super.position}) {
    speed = 240.0;
    fsm = CharacterFSM(character: this);
  }
}
