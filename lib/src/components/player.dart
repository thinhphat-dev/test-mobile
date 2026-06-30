import 'package:flutter/material.dart';
import 'stickman_base.dart';

/// Lớp nhân vật Người chơi (Player), kế thừa từ StickmanBase.
/// Đại diện cho nhân vật do người dùng điều khiển, mặc định màu xanh dương.
class Player extends StickmanBase {
  Player({required super.position});

  @override
  Color get characterColor => const Color(0xFF4fc3f7); // Màu xanh dương sáng

  @override
  String toString() => 'Player';
}
