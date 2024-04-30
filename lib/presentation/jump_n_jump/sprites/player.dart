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
  PlayerState({required this.isMoving, required this.isMovingDown, required this.isLowHealth});
  
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

  Player({super.position, this.character, this.audioManager})
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
  final ValueNotifier<double> health = ValueNotifier<double>(100);

  final int movingLeftInput = -1;
  final int movingRightInput = 1;

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
        isMoving: false, isMovingDown: false, isLowHealth: false,
      ): idle!,
      PlayerState(
        isMoving: true, isMovingDown: false, isLowHealth: false,
      ): move!,
      PlayerState(
        isMoving: false, isMovingDown: true, isLowHealth: false,
      ): idleDown!,
      PlayerState(
        isMoving: true, isMovingDown: true, isLowHealth: false,
      ): moveDown!,
      PlayerState(
        isMoving: false, isMovingDown: false, isLowHealth: true,
      ): idleTired!,
      PlayerState(
        isMoving: true, isMovingDown: false, isLowHealth: true,
      ): moveTired!,
      PlayerState(
        isMoving: false, isMovingDown: true, isLowHealth: true,
      ): idleDownTired!,
      PlayerState(
        isMoving: true, isMovingDown: true, isLowHealth: true,
      ): moveDownTired!,
    };

    current = PlayerState(
        isMoving: false, isMovingDown: false, isLowHealth: false,
      );
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

    if (health.value < 30) {
      current?.isLowHealth = true;
    } else {
      current?.isLowHealth = false;
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
      increaseHealth(7);
    }

    super.onCollision(intersectionPoints, other);
  }

  void jump() {
    audioManager!.playSoundEffect('jump_n_jump/jump_on_platform.wav', 1);
    velocity.y = -jumpSpeed;
  }

  void megaJump() {
    velocity.y = -jumpSpeed * 1.5;
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
      idle =
          await gameRef.loadSprite('jump_n_jump/characters/boy_idle.png');
      move =
          await gameRef.loadSprite('jump_n_jump/characters/boy_move.png');
      idleDown =
          await gameRef.loadSprite('jump_n_jump/characters/boy_idle_down.png');
      moveDown =
          await gameRef.loadSprite('jump_n_jump/characters/boy_move_down.png');
      idleTired =
          await gameRef.loadSprite('jump_n_jump/characters/boy_idle_tired.png');
      moveTired =
          await gameRef.loadSprite('jump_n_jump/characters/boy_move_tired.png');
      idleDownTired =
          await gameRef.loadSprite('jump_n_jump/characters/boy_idle_down_tired.png');
      moveDownTired =
          await gameRef.loadSprite('jump_n_jump/characters/boy_move_down_tired.png');
    } else if (character == Character.girl) {
      idle =
          await gameRef.loadSprite('jump_n_jump/characters/girl_idle.png');
      move =
          await gameRef.loadSprite('jump_n_jump/characters/girl_move.png');
      idleDown =
          await gameRef.loadSprite('jump_n_jump/characters/girl_idle_down.png');
      moveDown =
          await gameRef.loadSprite('jump_n_jump/characters/girl_move_down.png');
      idleTired =
          await gameRef.loadSprite('jump_n_jump/characters/girl_idle_tired.png');
      moveTired =
          await gameRef.loadSprite('jump_n_jump/characters/girl_move_tired.png');
      idleDownTired =
          await gameRef.loadSprite('jump_n_jump/characters/girl_idle_down_tired.png');
      moveDownTired =
          await gameRef.loadSprite('jump_n_jump/characters/girl_move_down_tired.png');
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
