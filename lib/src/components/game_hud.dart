import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../stickman_game.dart';
import 'player.dart';

/// Lớp giao diện người dùng (HUD) chứa Joystick và các nút bấm hành động.
/// Kế thừa PositionComponent và sử dụng mixin HasGameRef để truy cập vào game instance.
/// HUD là lớp tĩnh, không di chuyển theo camera, luôn hiển thị trên cùng màn hình.
class GameHud extends PositionComponent with HasGameRef<StickmanGame> {
  // Tham chiếu đến đối tượng Player để điều khiển
  Player? player;

  // Các nút bấm hành động
  late HudButtonComponent punchButton;
  late HudButtonComponent kickButton;
  late HudButtonComponent blockButton;
  late HudButtonComponent transformButton;

  // Joystick cho di chuyển
  late JoystickComponent joystick;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Cấu hình kích thước HUD bằng với viewport của game (1200x800)
    // Điều này đảm bảo các phần tử HUD được đặt đúng vị trí tương đối trên mọi màn hình
    size = Vector2(1200, 800);

    // Tạo Joystick ở góc dưới bên trái
    _createJoystick();

    // Tạo 4 nút bấm hành động ở góc dưới bên phải
    _createActionButtons();
  }

  /// Tạo Joystick với núm xoay (knob) và vòng tròn nền (background)
  void _createJoystick() {
    // Vòng tròn nền của joystick - màu đen nửa trong suốt
    final background = CircleComponent(
      radius: 70,
      paint: Paint()
        ..color = const Color(0x80000000) // Đen với độ trong suốt 50%
        ..style = PaintingStyle.fill,
      position: Vector2.zero(),
      anchor: Anchor.center,
    );

    // Núm xoay của joystick - màu xám nhạt nửa trong suốt
    final knob = CircleComponent(
      radius: 30,
      paint: Paint()
        ..color = const Color(0xC0CCCCCC) // Xám nhạt với độ trong suốt 25%
        ..style = PaintingStyle.fill,
      position: Vector2.zero(),
      anchor: Anchor.center,
    );

    // Tạo JoystickComponent với background và knob
    joystick = JoystickComponent(
      knob: knob,
      background: background,
      position: Vector2(150, 680), // Vị trí góc dưới bên trái
      anchor: Anchor.center,
      margin: const EdgeInsets.only(left: 20, bottom: 20),
    );

    add(joystick);
  }

  /// Tạo 4 nút bấm hành động: ĐẤM, ĐÁ, ĐỠ, BIẾN HÌNH
  void _createActionButtons() {
    // Kích thước chung cho các nút
    const double buttonSize = 60.0;
    const double spacing = 15.0;

    // Vị trí bắt đầu từ góc dưới bên phải
    final baseX = 1050.0;
    final baseY = 680.0;

    // --- Nút ĐẤM (Punch) - Vị trí thấp nhất, dễ nhấn nhất ---
    punchButton = _createActionButton(
      position: Vector2(baseX, baseY),
      label: 'ĐẤM',
      color: const Color(0xFFE74C3C), // Màu đỏ
      onPressed: () {
        // Xử lý khi nhấn nút ĐẤM
        debugPrint('Nút ĐẤM được nhấn');
      },
      onReleased: () {
        debugPrint('Nút ĐẤM được thả');
      },
    );
    add(punchButton);

    // --- Nút ĐÁ (Kick) - Bên phải nút ĐẤM ---
    kickButton = _createActionButton(
      position: Vector2(baseX + buttonSize + spacing, baseY),
      label: 'ĐÁ',
      color: const Color(0xFFF39C12), // Màu cam
      onPressed: () {
        debugPrint('Nút ĐÁ được nhấn');
      },
      onReleased: () {
        debugPrint('Nút ĐÁ được thả');
      },
    );
    add(kickButton);

    // --- Nút ĐỠ ĐÒN (Block) - Phía trên nút ĐẤM ---
    blockButton = _createActionButton(
      position: Vector2(baseX, baseY - buttonSize - spacing),
      label: 'ĐỠ',
      color: const Color(0xFF3498DB), // Màu xanh dương
      onPressed: () {
        debugPrint('Nút ĐỠ được nhấn');
      },
      onReleased: () {
        debugPrint('Nút ĐỠ được thả');
      },
    );
    add(blockButton);

    // --- Nút BIẾN HÌNH (Transform) - Phía trên nút ĐÁ ---
    transformButton = _createActionButton(
      position: Vector2(baseX + buttonSize + spacing, baseY - buttonSize - spacing),
      label: 'THÚ',
      color: const Color(0xFF9B59B6), // Màu tím
      onPressed: () {
        debugPrint('Nút BIẾN HÌNH được nhấn');
      },
      onReleased: () {
        debugPrint('Nút BIẾN HÌNH được thả');
      },
    );
    add(transformButton);
  }

  /// Hàm tiện ích tạo một nút bấm hành động với nhãn và màu sắc tùy chỉnh
  HudButtonComponent _createActionButton({
    required Vector2 position,
    required String label,
    required Color color,
    required VoidCallback onPressed,
    required VoidCallback onReleased,
  }) {
    return HudButtonComponent(
      button: RectangleComponent(
        size: Vector2(60, 60),
        paint: Paint()
          ..color = color.withOpacity(0.8)
          ..style = PaintingStyle.fill,
        children: [
          // Thêm nhãn chữ vào giữa nút
          TextComponent(
            text: label,
            textRenderer: TextPaint(
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            anchor: Anchor.center,
            position: Vector2(30, 30),
          ),
        ],
      ),
      buttonDownColor: color.withOpacity(1.0),
      position: position,
      anchor: Anchor.center,
      onPressed: onPressed,
      onReleased: onReleased,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Cập nhật trạng thái di chuyển của Player dựa trên Joystick
    if (player != null && !joystick.isIdle) {
      // Chỉ sử dụng trục X để di chuyển trái/phải
      // relativeDelta.x trả về giá trị từ -1.0 đến 1.0
      final moveSpeed = 250.0; // Tốc độ di chuyển cơ bản (pixel/giây)
      final deltaX = joystick.relativeDelta.x * moveSpeed * dt;

      // Cập nhật vị trí X của player
      player!.position.x += deltaX;

      // Giới hạn player không đi ra ngoài bản đồ (0 đến 1200)
      if (player!.position.x < 40) {
        player!.position.x = 40;
      } else if (player!.position.x > 1160) {
        player!.position.x = 1160;
      }

      // Tự động xoay hướng vẽ của player dựa trên vị trí tương đối so với bot
      // Đảm bảo hai nhân vật luôn quay mặt vào nhau
      if (gameRef.children.whereType<Bot>().isNotEmpty) {
        final bot = gameRef.children.whereType<Bot>().first;
        if (player!.position.x < bot.position.x) {
          // Player ở bên trái bot, quay mặt sang phải (scale.x = 1)
          player!.scale.x = 1.0;
        } else {
          // Player ở bên phải bot, quay mặt sang trái (scale.x = -1)
          player!.scale.x = -1.0;
        }
      }
    }
  }
}
