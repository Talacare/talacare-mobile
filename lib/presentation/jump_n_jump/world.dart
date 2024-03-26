import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:talacare/presentation/jump_n_jump/jump_n_jump.dart';

class WorldGame extends ParallaxComponent<JumpNJump> {
  @override
  Future<void> onLoad() async {
    parallax = await gameRef.loadParallax(
      [ParallaxImageData('jump_n_jump/background.png')],
    );
  }
}
