import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../jump_n_jump.dart';

class BloodBag extends SpriteComponent
    with HasGameRef<JumpNJump>, CollisionCallbacks {
  final hitbox = RectangleHitbox();

  BloodBag({
    super.position,
  }) : super(
          size: Vector2(90, 100),
          priority: 2,
        );

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite('jump_n_jump/blood_bag.png');

    await add(hitbox);
  }
}
