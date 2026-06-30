import 'package:flame/components.dart';
import 'package:flutter/material.dart';

/// Thành phần mặt đất (GroundComponent) nằm vững chắc ở đáy bản đồ ảo.
/// Mặt đất được vẽ ở tọa độ y = 700, chạy ngang toàn bộ chiều rộng bản đồ (1200px).
/// Sử dụng position và size chuẩn của PositionComponent để hỗ trợ hitbox/collision sau này.
class GroundComponent extends PositionComponent with HasGameRef {
  GroundComponent()
      : super(
          position: Vector2(0, 700),
          size: Vector2(1200, 100),
        );

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Tạo Paint để vẽ đường thẳng mặt đất
    final paint = Paint()
      ..color = const Color(0xFF4a4a6a) // Màu xám xanh cho mặt đất
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    // Vẽ đường thẳng ngang tại y=0 cục bộ (tức y=700 trong world)
    // Sử dụng tọa độ tương đối theo size của component
    canvas.drawLine(
      Offset.zero,
      Offset(size.x, 0),
      paint,
    );

    // Vẽ thêm một vài chi tiết trang trí cho mặt đất (các đường gạch nhỏ)
    final detailPaint = Paint()
      ..color = const Color(0xFF3a3a5a)
      ..strokeWidth = 2;

    for (int i = 0; i < 12; i++) {
      final x = i * 100.0 + 50;
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, 10),
        detailPaint,
      );
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Mặt đất là thành phần tĩnh, không cần cập nhật logic
  }
}

