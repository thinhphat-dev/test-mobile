import 'package:flame/components.dart';
import 'base_character.dart';
import '../state/character_fsm.dart';

class BlazeFighter extends BaseCharacter {
  late final CharacterFSM fsm;

  BlazeFighter({required super.position}) {
    speed = 260.0;
    fsm = CharacterFSM(character: this);
  }
}
