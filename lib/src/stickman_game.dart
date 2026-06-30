import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'components/ground_component.dart';
import 'components/player.dart';
import 'components/bot.dart';

/// Lớp quản lý vòng lặp game chính, kế thừa từ FlameGame.
/// Thiết lập CameraComponent với độ phân giải ảo cố định 1200x800 pixel
/// để đảm bảo trò chơi tự động co giãn sắc nét trên mọi thiết bị mà không bị biến dạng.
class StickmanGame extends FlameGame {
  StickmanGame() : super();

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Thiết lập Camera với viewport cố định 1200x800
    // Cơ chế co giãn tọa độ:
    // - Flame sẽ tự động scale toàn bộ nội dung trong world để vừa với màn hình thực tế
    // - Tọa độ logic luôn nằm trong khoảng x: 0-1200, y: 0-800 bất kể kích thước màn hình thật
    // - Điều này giúp việc tính toán vật lý và vị trí nhất quán trên mọi device
    camera.viewport = FixedResolutionViewport(Vector2(1200, 800));

    // Thêm thành phần mặt đất vào thế giới game
    final ground = GroundComponent();
    add(ground);

    // Tạo và thêm người chơi (Player) tại vị trí x = 300
    final player = Player(position: Vector2(300, 700));
    add(player);

    // Tạo và thêm đối thủ máy (Bot) tại vị trí x = 900
    final bot = Bot(position: Vector2(900, 700));
    add(bot);
  }

  @override
  Color backgroundColor() => const Color(0xFF1a1a2e); // Màu nền xanh đen đậm
}
