import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:talacare/presentation/jump_n_jump/interface/audio_manager_interface.dart';
import 'package:talacare/core/enums/character_enum.dart';
import 'package:flutter/material.dart';
import 'blood_bag.dart';

import '../jump_n_jump.dart';
import 'platform.dart';

enum DashDirection { left, right }

class PlayerState {
  bool isMoving, isMovingDown, isLowHealth;
  PlayerState(
      {required this.isMoving,
      required this.isMovingDown,
      required this.isLowHealth});

  @override
  bool operator ==(Object other) {
    return other is PlayerState &&
        isMoving == other.isMoving &&
        isMovingDown == other.isMovingDown &&
        isLowHealth == other.isLowHealth;
  }

  @override
  int get hashCode => Object.hash(isMoving, isMovingDown, isLowHealth);
}

class Player extends SpriteGroupComponent<PlayerState>
    with HasGameRef<JumpNJump>, KeyboardHandler, CollisionCallbacks {
  late IAudioManager? audioManager;
  late Character? character;

  static const double originalMoveSpeed = 400;
  static const double originalJumpSpeed = 1000;
  static const double lowHealthMoveSpeedMultiplier = 0.5;
  static const double lowHealthJumpSpeedMultiplier = 0.8;
  static const double megaJumpSpeedMultiplier = 1.5;
  static const double lowHealthThreshold = 30;
  static const double healthIncreaseBloodBag = 7;
  static const double minHealth = 0;
  static const double maxHealth = 100;
  static const double gravity = 14;
  static const int originalHAxisInput = 0;
  static const int movingLeftInput = -1;
  static const int movingRightInput = 1;

  Player({super.position, this.character, this.audioManager})
      : super(
          size: Vector2(70, 120),
          anchor: Anchor.center,
          priority: 1,
        );

  Vector2 velocity = Vector2.zero();

  double moveSpeed = originalMoveSpeed;
  double jumpSpeed = originalJumpSpeed;
  int hAxisInput = originalHAxisInput;

  final ValueNotifier<double> health = ValueNotifier<double>(100);

  bool _isMovingLeft = false;
  bool _isMovingRight = false;

  Sprite? idle;
  Sprite? move;
  Sprite? idleDown;
  Sprite? moveDown;
  Sprite? idleTired;
  Sprite? moveTired;
  Sprite? idleDownTired;
  Sprite? moveDownTired;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    await add(CircleHitbox());

    await handleCharacterAsset();

    sprites = <PlayerState, Sprite>{
      PlayerState(
        isMoving: false,
        isMovingDown: false,
        isLowHealth: false,
      ): idle!,
      PlayerState(
        isMoving: true,
        isMovingDown: false,
        isLowHealth: false,
      ): move!,
      PlayerState(
        isMoving: false,
        isMovingDown: true,
        isLowHealth: false,
      ): idleDown!,
      PlayerState(
        isMoving: true,
        isMovingDown: true,
        isLowHealth: false,
      ): moveDown!,
      PlayerState(
        isMoving: false,
        isMovingDown: false,
        isLowHealth: true,
      ): idleTired!,
      PlayerState(
        isMoving: true,
        isMovingDown: false,
        isLowHealth: true,
      ): moveTired!,
      PlayerState(
        isMoving: false,
        isMovingDown: true,
        isLowHealth: true,
      ): idleDownTired!,
      PlayerState(
        isMoving: true,
        isMovingDown: true,
        isLowHealth: true,
      ): moveDownTired!,
    };

    current = PlayerState(
      isMoving: false,
      isMovingDown: false,
      isLowHealth: false,
    );
  }

  @override
  void update(double dt) {
    if (_isMovingLeft) {
      hAxisInput = movingLeftInput;
    } else if (_isMovingRight) {
      hAxisInput = movingRightInput;
    } else {
      hAxisInput = originalHAxisInput;
    }

    if (health.value < lowHealthThreshold) {
      current?.isLowHealth = true;
      moveSpeed = originalMoveSpeed * lowHealthMoveSpeedMultiplier;
    } else {
      current?.isLowHealth = false;
      moveSpeed = originalMoveSpeed;
    }

    velocity.x = hAxisInput * moveSpeed;
    velocity.y += gravity;

    if (position.x < -(size.x / 2)) {
      position.x = gameRef.size.x + size.x / 2;
    }
    if (position.x > gameRef.size.x + size.x / 2) {
      position.x = -(size.x / 2);
    }

    if (velocity.y > 0) {
      current?.isMovingDown = true;
    } else {
      current?.isMovingDown = false;
    }

    position += velocity * dt;
    super.update(dt);
  }

  bool get isMovingDown => velocity.y > 0;

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Platform) {
      bool isMovingDown = velocity.y > 0;
      bool isCollidingWithFeet =
          other.position.y - (position.y + size.y / 2) > -45;

      if (isMovingDown && isCollidingWithFeet) {
        jump();
      }
    }

    if (other is BloodBag) {
      other.removeFromParent();
      increaseHealth(healthIncreaseBloodBag);
    }

    super.onCollision(intersectionPoints, other);
  }

  void jump() {
    audioManager!.playSoundEffect('jump_n_jump/jump_on_platform.wav', 1);
    if (health.value < lowHealthThreshold) {
      velocity.y = -jumpSpeed * lowHealthJumpSpeedMultiplier;
    } else {
      velocity.y = -jumpSpeed;
    }
  }

  void megaJump() {
    if (health.value < lowHealthThreshold) {
      velocity.y =
          -jumpSpeed * megaJumpSpeedMultiplier * lowHealthJumpSpeedMultiplier;
    } else {
      velocity.y = -jumpSpeed * megaJumpSpeedMultiplier;
    }
  }

  void handleControlButtonPress(DashDirection direction, bool isPressed) {
    if (direction == DashDirection.left) {
      _isMovingLeft = isPressed;
      if (isPressed) {
        current?.isMoving = true;
      } else {
        current?.isMoving = false;
      }
    } else if (direction == DashDirection.right) {
      _isMovingRight = isPressed;
      if (isPressed) {
        current?.isMoving = true;
      } else {
        current?.isMoving = false;
      }
      flipHorizontally();
    }
  }

  Future<void> handleCharacterAsset() async {
    if (character == Character.boy) {
      idle = await gameRef.loadSprite('jump_n_jump/characters/boy_idle.png');
      move = await gameRef.loadSprite('jump_n_jump/characters/boy_move.png');
      idleDown =
          await gameRef.loadSprite('jump_n_jump/characters/boy_idle_down.png');
      moveDown =
          await gameRef.loadSprite('jump_n_jump/characters/boy_move_down.png');
      idleTired =
          await gameRef.loadSprite('jump_n_jump/characters/boy_idle_tired.png');
      moveTired =
          await gameRef.loadSprite('jump_n_jump/characters/boy_move_tired.png');
      idleDownTired = await gameRef
          .loadSprite('jump_n_jump/characters/boy_idle_down_tired.png');
      moveDownTired = await gameRef
          .loadSprite('jump_n_jump/characters/boy_move_down_tired.png');
    } else if (character == Character.girl) {
      idle = await gameRef.loadSprite('jump_n_jump/characters/girl_idle.png');
      move = await gameRef.loadSprite('jump_n_jump/characters/girl_move.png');
      idleDown =
          await gameRef.loadSprite('jump_n_jump/characters/girl_idle_down.png');
      moveDown =
          await gameRef.loadSprite('jump_n_jump/characters/girl_move_down.png');
      idleTired = await gameRef
          .loadSprite('jump_n_jump/characters/girl_idle_tired.png');
      moveTired = await gameRef
          .loadSprite('jump_n_jump/characters/girl_move_tired.png');
      idleDownTired = await gameRef
          .loadSprite('jump_n_jump/characters/girl_idle_down_tired.png');
      moveDownTired = await gameRef
          .loadSprite('jump_n_jump/characters/girl_move_down_tired.png');
    }
  }

  void increaseHealth(double amount) {
    double newHealth = health.value + amount;
    health.value = newHealth.clamp(minHealth, maxHealth);
  }

  void decreaseHealth(double amount) {
    double newHealth = health.value - amount;
    health.value = newHealth.clamp(minHealth, maxHealth);
  }
}
