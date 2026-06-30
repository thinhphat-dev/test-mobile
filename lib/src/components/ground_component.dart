import 'package:flame/components.dart';
import 'package:flutter/material.dart';

/// Thành phần mặt đất (GroundComponent) nằm vững chắc ở đáy bản đồ ảo.
/// Mặt đất được vẽ ở tọa độ y = 700, chạy ngang toàn bộ chiều rộng bản đồ (1200px).
class GroundComponent extends PositionComponent with HasGameRef {
  GroundComponent() : super();

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Tạo Paint để vẽ đường thẳng mặt đất
    final paint = Paint()
      ..color = const Color(0xFF4a4a6a) // Màu xám xanh cho mặt đất
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    // Vẽ đường thẳng ngang từ x=0 đến x=1200 tại y=700 (trong hệ tọa độ local của component này)
    // Vì component này không set size cụ thể, ta vẽ trực tiếp trên canvas game thông qua vị trí tuyệt đối
    // Tuy nhiên, để đơn giản, ta sẽ vẽ một đường thẳng ngang trong phương thức render của game world
    
    // Cách tiếp cận đúng: Vẽ trực tiếp lên canvas với tọa độ tuyệt đối trong world
    canvas.drawLine(
      const Offset(0, 700),
      const Offset(1200, 700),
      paint,
    );

    // Vẽ thêm một vài chi tiết trang trí cho mặt đất (các đường gạch nhỏ)
    final detailPaint = Paint()
      ..color = const Color(0xFF3a3a5a)
      ..strokeWidth = 2;

    for (int i = 0; i < 12; i++) {
      final x = i * 100.0 + 50;
      canvas.drawLine(
        Offset(x, 700),
        Offset(x, 710),
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
