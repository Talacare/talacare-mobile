import 'dart:math';

import 'package:flame/components.dart';
import 'package:talacare/presentation/jump_n_jump/managers/object_manager.dart';

import '../jump_n_jump.dart';
import '../sprites/platform.dart';

class PlatformManager extends ObjectManager<Platform> {
  PlatformManager()
      : super(350, 200);

  @override
  Platform createItem(Vector2 position) {
    return Platform(position: position);
  }

  @override
  void increaseScore() {
    gameRef.gameManager.increaseScore();
  }
}
