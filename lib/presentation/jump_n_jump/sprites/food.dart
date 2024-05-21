import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../jump_n_jump.dart';

class Food extends SpriteComponent
    with HasGameRef<JumpNJump>, CollisionCallbacks {
  final hitbox = RectangleHitbox();

  Food({
    super.position,
  }) : super(
          size: Vector2(50, 50),
          priority: 2,
        );

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite('jump_n_jump/foods/food0.png');

    await add(hitbox);
  }
}
