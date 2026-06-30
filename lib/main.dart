import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flame/game.dart';
import 'src/stickman_game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Ép buộc hướng xoay ngang màn hình (Landscape)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // Ẩn thanh trạng thái hệ thống để trải nghiệm game toàn màn hình
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Khởi tạo instance cố định để tránh tạo lại game khi widget rebuild
  static final _game = StickmanGame();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: GameWidget(game: _game),
      ),
    );
  }
}
