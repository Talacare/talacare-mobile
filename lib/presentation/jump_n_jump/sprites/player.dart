import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';

import '../jump_n_jump.dart';
import 'platform.dart';

enum DashDirection { left, right }

class Player extends SpriteGroupComponent<DashDirection>
    with HasGameRef<JumpNJump>, KeyboardHandler, CollisionCallbacks {
  Player({super.position})
      : super(
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

  @override
  // ignore: deprecated_member_use
  bool onKeyEvent(RawKeyEvent? event, Set<LogicalKeyboardKey> keysPressed) {
    _hAxisInput = 0;

    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      moveLeft();
    }

    if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      moveRight();
    }

    return true;
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
    velocity.y = -jumpSpeed;
  }

  void megaJump() {
    velocity.y = -jumpSpeed * 1.5;
  }

  void moveLeft() {
    _hAxisInput = 0;
    current = DashDirection.left;
    _hAxisInput += movingLeftInput;
  }

  void moveRight() {
    _hAxisInput = 0;
    current = DashDirection.right;
    _hAxisInput += movingRightInput;
  }

  void stop() {
    _hAxisInput = 0;
  }
}
