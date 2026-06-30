import 'package:flutter/material.dart';
import 'stickman_base.dart';

/// Lớp nhân vật Đối thủ máy (Bot), kế thừa từ StickmanBase.
/// Đại diện cho nhân vật do máy điều khiển, mặc định màu đỏ cam.
class Bot extends StickmanBase {
  Bot({required super.position});

  @override
  Color get characterColor => const Color(0xFFff7043); // Màu đỏ cam sáng

  @override
  String toString() => 'Bot';
}
