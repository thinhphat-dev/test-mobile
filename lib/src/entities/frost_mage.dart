import 'package:flame/components.dart';
import 'base_character.dart';
import '../state/character_fsm.dart';

class FrostMage extends BaseCharacter {
  late final CharacterFSM fsm;

  FrostMage({required super.position}) {
    speed = 190.0;
    fsm = CharacterFSM(character: this);
  }
}
