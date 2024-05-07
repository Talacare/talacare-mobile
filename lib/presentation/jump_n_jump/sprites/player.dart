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
  bool isGameOver;

  Player(
      {super.position,
      this.character,
      this.audioManager,
      this.isGameOver = false})
      : super(
          size: Vector2(70, 120),
          anchor: Anchor.center,
          priority: 1,
        );

  Vector2 velocity = Vector2.zero();
  int _hAxisInput = 0;

  final double moveSpeed = 400;
  final double _gravity = 14;
  final double jumpSpeed = 1000;
  final ValueNotifier<double> health = ValueNotifier<double>(100);

  final int movingLeftInput = -1;
  final int movingRightInput = 1;

  bool _isMovingLeft = false;
  bool _isMovingRight = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    await add(CircleHitbox());

    List<PlayerState> states = [];
    for (var isMoving in [false, true]) {
      for (var isMovingDown in [false, true]) {
        for (var isLowHealth in [false, true]) {
          states.add(PlayerState(
            isMoving: isMoving,
            isMovingDown: isMovingDown,
            isLowHealth: isLowHealth,
          ));
        }
      }
    }

    Map<PlayerState, Sprite> spritesMap = {};

    for (var state in states) {
      String key = getStateKey(state);
      spritesMap[state] = await gameRef.loadSprite(key);
    }

    sprites = spritesMap;

    current = PlayerState(
      isMoving: false,
      isMovingDown: false,
      isLowHealth: false,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (isGameOver) {
      velocity.x = 0;
      velocity.y = 500;
      position += velocity * dt;
      current?.isMovingDown = true;
      return;
    }

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
  }

  bool get isMovingDown => velocity.y > 0;

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Platform) {
      bool isMovingDown = velocity.y > 0;
      bool isCollidingWithFeet =
          other.position.y - (position.y + size.y / 2) > -45;

      if (isMovingDown && isCollidingWithFeet && !isGameOver) {
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
      if (isPressed && !isGameOver) {
        current?.isMoving = true;
      } else {
        current?.isMoving = false;
      }
    } else if (direction == DashDirection.right) {
      _isMovingRight = isPressed;
      if (isPressed && !isGameOver) {
        current?.isMoving = true;
      } else {
        current?.isMoving = false;
      }
      flipHorizontally();
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

  String getStateKey(PlayerState state) {
    String characterBase =
        'jump_n_jump/characters/${character.toString().split('.').last}';
    String key = state.isMoving ? 'move' : 'idle';
    if (state.isMovingDown) key += '_down';
    if (state.isLowHealth) key += '_tired';
    return '${characterBase}_$key.png';
  }
}
