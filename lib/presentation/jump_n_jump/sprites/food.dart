import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../jump_n_jump.dart';

class Food extends SpriteComponent
    with HasGameRef<JumpNJump>, CollisionCallbacks {
  final hitbox = RectangleHitbox();
  final Random random = Random();

  Food({
    super.position,
  }) : super(
          size: Vector2(50, 50),
          priority: 2,
        );

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    int randomIndex = random.nextInt(10);
    sprite = await gameRef.loadSprite('jump_n_jump/foods/food$randomIndex.png');

    await add(hitbox);
  }
}
