import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../arena/battle_arena.dart';
import '../components/hud.dart';
import '../entities/bot_opponent.dart';
import '../entities/player.dart';
import '../input/game_controller.dart';
import '../state/character_state.dart';
import 'main_menu_screen.dart';

class BattleScreen extends PositionComponent with HasGameRef<AdvancedFightingGame> {
  late final Player player;
  late final BotOpponent bot;
  late final GameController joystick;
  late final GameHUD hud;
  late final BattleArena arena;
  bool _gameEnded = false;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = gameRef.size;

    // Cấu hình Viewport camera thế giới cho trận đấu
    gameRef.camera.viewport = FixedResolutionViewport(resolution: Vector2(AdvancedFightingGame.virtualWidth, AdvancedFightingGame.virtualHeight));

    // 1. Khởi tạo đấu trường và thêm vào thế giới game
    arena = BattleArena();
    await gameRef.world.add(arena);

    // 2. Khởi tạo bộ điều khiển Joystick
    joystick = GameController();
    add(joystick);

    // 3. Khởi tạo người chơi và thêm vào thế giới game
    player = Player(
      position: Vector2(200, 600),
      joystick: joystick,
    );
    await gameRef.world.add(player);

    // 4. Khởi tạo đối thủ (Bot) và thêm vào thế giới game
    bot = BotOpponent(
      position: Vector2(800, 600),
      playerTarget: player,
    );
    await gameRef.world.add(bot);

    // 5. Khởi tạo HUD (Thanh máu)
    hud = GameHUD();
    add(hud);

    // 6. Cho camera theo dõi người chơi
    gameRef.camera.follow(player);

    // 7. Thêm nút đấm nhẹ (Punch)
    add(
      ActionButton(
        'PUNCH',
        position: Vector2(size.x - 220, size.y - 90),
        color: const Color(0xFF00FF66),
        onTap: () {
          player.fsm.transitionTo(CharacterState.lightAttack);
        },
      ),
    );

    // 8. Thêm nút kỹ năng (Skill)
    add(
      ActionButton(
        'SKILL',
        position: Vector2(size.x - 90, size.y - 150),
        color: const Color(0xFFFFCC00),
        onTap: () {
          player.fsm.transitionTo(CharacterState.heavyAttack);
        },
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Kiểm tra phân định thắng bại khi máu 1 bên về 0
    if (!_gameEnded) {
      if (bot.hp <= 0) {
        _gameEnded = true;
        _showEndGameOverlay(victory: true);
      } else if (player.hp <= 0) {
        _gameEnded = true;
        _showEndGameOverlay(victory: false);
      }
    }
  }

  void _showEndGameOverlay({required bool victory}) {
    // Phủ màn mờ tối
    final overlayBg = RectangleComponent(
      size: size,
      paint: Paint()..color = Colors.black.withOpacity(0.8),
    );
    add(overlayBg);

    // Chữ VICTORY / DEFEAT
    add(
      TextComponent(
        text: victory ? 'VICTORY' : 'DEFEAT',
        textRenderer: TextPaint(
          style: TextStyle(
            color: victory ? const Color(0xFFFFCC00) : const Color(0xFFFF3333),
            fontSize: 48,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          ),
        ),
        position: Vector2(size.x / 2, size.y * 0.4),
        anchor: Anchor.center,
      ),
    );

    // Nút quay lại màn hình chính
    add(
      MenuButton(
        'BACK TO MENU',
        position: Vector2(size.x / 2, size.y * 0.6),
        onTap: () {
          gameRef.router.pushReplacementNamed('menu');
        },
      ),
    );
  }

  @override
  void onRemove() {
    // Dọn dẹp tài nguyên khi thoát trận
    gameRef.world.removeAll(gameRef.world.children);
    gameRef.camera.stop();
    gameRef.camera.viewport = MaxViewport();
    super.onRemove();
  }
}

/// Nút bấm tròn thực hiện hành động đấm / kỹ năng
class ActionButton extends PositionComponent with TapCallbacks {
  final String label;
  final Color color;
  final VoidCallback onTap;

  ActionButton(
    this.label, {
    required Vector2 position,
    required this.color,
    required this.onTap,
  }) : super(
          position: position,
          size: Vector2(80, 80),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Nền nút bấm bán trong suốt
    add(
      CircleComponent(
        radius: 40,
        paint: Paint()
          ..color = color.withOpacity(0.15)
          ..style = PaintingStyle.fill,
      ),
    );

    // Viền nút bấm sáng neon
    add(
      CircleComponent(
        radius: 40,
        paint: Paint()
          ..color = color
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke,
      ),
    );

    // Nhãn văn bản giữa nút
    add(
      TextComponent(
        text: label,
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        position: Vector2(40, 40),
        anchor: Anchor.center,
      ),
    );
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    onTap();
  }
}
