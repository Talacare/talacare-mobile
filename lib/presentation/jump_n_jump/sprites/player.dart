import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:talacare/core/enums/character_enum.dart';
import 'package:flutter/material.dart';
import 'blood_bag.dart';

import '../jump_n_jump.dart';
import 'platform.dart';

enum DashDirection { left, right }

class Player extends SpriteGroupComponent<DashDirection>
    with HasGameRef<JumpNJump>, KeyboardHandler, CollisionCallbacks {
  late Character? character;

  Player({super.position, this.character})
      : super(
          size: Vector2(80, 160),
          anchor: Anchor.center,
          priority: 1,
        );

  Vector2 velocity = Vector2.zero();
  int _hAxisInput = 0;

  final double moveSpeed = 400;
  final double _gravity = 7;
  final double jumpSpeed = 700;
  final ValueNotifier<double> health = ValueNotifier<double>(100);

  final int movingLeftInput = -1;
  final int movingRightInput = 1;

  bool _isMovingLeft = false;
  bool _isMovingRight = false;

  Sprite? leftDash;
  Sprite? rightDash;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await add(CircleHitbox());

    await handleCharacterAsset();

    sprites = <DashDirection, Sprite>{
      DashDirection.left: leftDash!,
      DashDirection.right: rightDash!,
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

    if (other is BloodBag) {
      bool isCollidingVertically =
          (intersectionPoints.first.y - intersectionPoints.last.y).abs() < 5;

      if (isCollidingVertically) {
        other.removeFromParent();
        increaseHealth(7);
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

  Future<void> handleCharacterAsset() async {
    if (character == Character.boy) {
      leftDash =
          await gameRef.loadSprite('jump_n_jump/characters/boy_left.png');
      rightDash =
          await gameRef.loadSprite('jump_n_jump/characters/boy_right.png');
    } else if (character == Character.girl) {
      leftDash =
          await gameRef.loadSprite('jump_n_jump/characters/girl_left.png');
      rightDash =
          await gameRef.loadSprite('jump_n_jump/characters/girl_right.png');
    }
  }

  void increaseHealth(double amount) {
    double newHealth = health.value + amount;
    health.value = newHealth.clamp(0.0, 100.0);
  }

  void decreaseHealth(double amount) {
    double newHealth = health.value - amount;
    health.value = newHealth.clamp(0.0, 100.0);
  }
}
