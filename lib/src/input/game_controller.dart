import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class GameController extends JoystickComponent {
  GameController()
      : super(
          knob: CircleComponent(
            radius: 25,
            paint: Paint()..color = const Color(0xAAFFFFFF),
          ),
          background: CircleComponent(
            radius: 65,
            paint: Paint()..color = const Color(0x33FFFFFF),
          ),
          margin: const EdgeInsets.only(left: 60, bottom: 60),
        );
}
