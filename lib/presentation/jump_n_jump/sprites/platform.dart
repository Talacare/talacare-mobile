import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../jump_n_jump.dart';

class Platform extends SpriteComponent
    with HasGameRef<JumpNJump>, CollisionCallbacks {
  final hitbox = RectangleHitbox();

  Platform({
    super.position,
  }) : super(
          size: Vector2.all(50),
          priority: 2,
        );

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite('jump_n_jump/platform.png');

    await add(hitbox);
  }
}
