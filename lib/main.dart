import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Khóa thiết bị ở chế độ hiển thị ngang
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  
  // Vô hiệu hóa thanh trạng thái hệ thống
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  final game = AdvancedFightingGame();
  runApp(
    GameWidget(
      game: game,
    ),
  );
}

class AdvancedFightingGame extends FlameGame {
  // Định nghĩa kích thước khung nhìn ảo tiêu chuẩn để co giãn tỷ lệ đồ họa
  static const double virtualWidth = 1280.0;
  static const double virtualHeight = 720.0;

  @override
  Color backgroundColor() => const Color(0xFF09090E);
}
