import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:talacare/presentation/jump_n_jump/interface/audio_manager_interface.dart';

import '../jump_n_jump.dart';
import 'platform.dart';

enum DashDirection { left, right }

class Player extends SpriteGroupComponent<DashDirection>
    with HasGameRef<JumpNJump>, KeyboardHandler, CollisionCallbacks {
  late IAudioManager _audioManager;

  Player({super.position, required IAudioManager audioManager})
      : _audioManager = audioManager,
        super(
          size: Vector2(70, 120),
          anchor: Anchor.center,
          priority: 1,
        );

  Vector2 velocity = Vector2.zero();

  int _hAxisInput = 0;

  final double moveSpeed = 400;
  final double _gravity = 7;
  final double jumpSpeed = 700;

  final int movingLeftInput = -1;
  final int movingRightInput = 1;

  bool _isMovingLeft = false;
  bool _isMovingRight = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    await add(CircleHitbox());

    final leftDash = await gameRef.loadSprite('jump_n_jump/left_dash.png');

    final rightDash = await gameRef.loadSprite('jump_n_jump/right_dash.png');

    sprites = <DashDirection, Sprite>{
      DashDirection.left: leftDash,
      DashDirection.right: rightDash,
    };

    current = DashDirection.right;
  }

  @override
  void update(double dt) {
    if (_isMovingLeft) {
      _hAxisInput = movingLeftInput;
    } else if (_isMovingRight) {
      _hAxisInput = movingRightInput;
    } else {
      _hAxisInput = 0;
    }

    velocity.x = _hAxisInput * moveSpeed;
    velocity.y += _gravity;

    if (position.x < size.x / 2) {
      position.x = gameRef.size.x + size.x + 10;
    }
    if (position.x > gameRef.size.x + size.x + 10) {
      position.x = size.x / 2;
    }

    position += velocity * dt;
    super.update(dt);
  }

  bool get isMovingDown => velocity.y > 0;

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Platform) {
      bool isMovingDown = velocity.y > 0;
      bool isCollidingVertically =
          (intersectionPoints.first.y - intersectionPoints.last.y).abs() < 5;

      if (isMovingDown && isCollidingVertically) {
        jump();
      }
    }

    super.onCollision(intersectionPoints, other);
  }

  void jump() {
    _audioManager.playSoundEffect('jump_n_jump/jump_on_platform.wav', 1);
    velocity.y = -jumpSpeed;
  }

  void megaJump() {
    velocity.y = -jumpSpeed * 1.5;
  }

  void handleControlButtonPress(DashDirection direction, bool isPressed) {
    if (direction == DashDirection.left) {
      _isMovingLeft = isPressed;
      if (isPressed) {
        current = DashDirection.left;
      }
    } else if (direction == DashDirection.right) {
      _isMovingRight = isPressed;
      if (isPressed) {
        current = DashDirection.right;
      }
    }
  }
}
