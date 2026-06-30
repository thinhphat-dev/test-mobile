import 'package:flame/components.dart';
import 'package:flutter/material.dart';

/// Lớp trừu tượng cơ sở cho nhân vật người que (StickmanBase).
/// Kế thừa từ PositionComponent để có thể định vị và vẽ trên bản đồ game.
/// Sử dụng phương pháp vẽ động hình học (Dynamic Vector Sketching) thay vì sprite.
abstract class StickmanBase extends PositionComponent {
  /// Bán kính đầu của stickman
  final double headRadius = 15;
  
  /// Độ dày nét vẽ
  final double strokeWidth = 4;
  
  /// Màu sắc của nhân vật (sẽ được override bởi Player và Bot)
  Color get characterColor;

  StickmanBase({required super.position});

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Tạo Paint với các thuộc tính vẽ nét mảnh, đầu tròn
    final paint = Paint()
      ..color = characterColor
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Tọa độ các khớp xương cơ bản của stickman ở trạng thái đứng yên (Idle)
    // Gốc tọa độ (0,0) của component này chính là vị trí feet (chân chạm đất)
    final centerX = 0.0; // Trung tâm theo trục X của nhân vật
    final feetY = 0.0;   // Vị trí chân (gốc của component)

    // Tính toán các điểm khớp dựa trên tỷ lệ cơ thể người chuẩn
    final hipY = -60.0;       // Hông cách chân 60px
    final shoulderY = -100.0; // Vai cách chân 100px (thấp hơn cổ)
    final neckY = -110.0;     // Cổ cách chân 110px (cao hơn vai)
    final headCenterY = neckY - 20.0; // Tâm đầu cách cổ 20px

    // Điểm hông (trung tâm thân dưới)
    final hipPoint = Offset(centerX, hipY);
    
    // Điểm vai trái và phải
    final leftShoulder = Offset(centerX - 20.0, shoulderY);
    final rightShoulder = Offset(centerX + 20.0, shoulderY);
    
    // Điểm cổ
    final neckPoint = Offset(centerX, neckY);
    
    // Điểm tâm đầu
    final headCenter = Offset(centerX, headCenterY);
    
    // Điểm khuỷu tay trái/phải (tay buông tự nhiên)
    final leftElbow = Offset(centerX - 25.0, shoulderY + 30.0);
    final rightElbow = Offset(centerX + 25.0, shoulderY + 30.0);
    
    // Điểm bàn tay trái/phải
    final leftHand = Offset(centerX - 20.0, hipY);
    final rightHand = Offset(centerX + 20.0, hipY);
    
    // Điểm đầu gối trái/phải
    final leftKnee = Offset(centerX - 10.0, hipY + 30.0);
    final rightKnee = Offset(centerX + 10.0, hipY + 30.0);
    
    // Điểm bàn chân trái/phải (chạm đất tại gốc hoặc gần gốc)
    final leftFoot = Offset(centerX - 15.0, feetY);
    final rightFoot = Offset(centerX + 15.0, feetY);

    // --- Vẽ ĐẦU ---
    canvas.drawCircle(headCenter, headRadius, paint);

    // --- Vẽ THÂN (Cổ đến Hông) ---
    canvas.drawLine(neckPoint, hipPoint, paint);

    // --- Vẽ VAI (Nối vai trái qua cổ đến vai phải) ---
    canvas.drawLine(leftShoulder, neckPoint, paint);
    canvas.drawLine(neckPoint, rightShoulder, paint);

    // --- Vẽ TAY TRÁI (Vai -> Khuỷu -> Bàn tay) ---
    canvas.drawLine(leftShoulder, leftElbow, paint);
    canvas.drawLine(leftElbow, leftHand, paint);

    // --- Vẽ TAY PHẢI (Vai -> Khuỷu -> Bàn tay) ---
    canvas.drawLine(rightShoulder, rightElbow, paint);
    canvas.drawLine(rightElbow, rightHand, paint);

    // --- Vẽ CHÂN TRÁI (Hông -> Đầu gối -> Bàn chân) ---
    canvas.drawLine(hipPoint, leftKnee, paint);
    canvas.drawLine(leftKnee, leftFoot, paint);

    // --- Vẽ CHÂN PHẢI (Hông -> Đầu gối -> Bàn chân) ---
    canvas.drawLine(hipPoint, rightKnee, paint);
    canvas.drawLine(rightKnee, rightFoot, paint);
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Logic cập nhật sẽ được triển khai bởi lớp con (Player/Bot)
    // Hoặc thêm vào sau khi có hệ thống trạng thái và vật lý
  }

  /// Phương thức trừu tượng để lấy trạng thái hiện tại (Người hay Thú)
  bool get isBeastForm => false;
}
