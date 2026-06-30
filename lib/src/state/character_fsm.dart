import '../../src/entities/base_character.dart';
import 'character_state.dart';

class CharacterFSM {
  final BaseCharacter character;
  CharacterState _currentState = CharacterState.idle;

  CharacterFSM({required this.character});

  CharacterState get currentState => _currentState;

  void transitionTo(CharacterState newState) {
    if (_currentState == CharacterState.dead) return;
    
    _currentState = newState;
    _applyStateBehavior();
  }

  void _applyStateBehavior() {
    switch (_currentState) {
      case CharacterState.idle:
        break;
      case CharacterState.walk:
        break;
      case CharacterState.lightAttack:
      case CharacterState.heavyAttack:
        break;
      case CharacterState.hit:
        break;
      case CharacterState.dead:
        break;
    }
  }
}
