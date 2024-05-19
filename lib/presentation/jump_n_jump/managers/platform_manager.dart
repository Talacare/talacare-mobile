import 'dart:math';

import 'package:flame/components.dart';

import '../jump_n_jump.dart';
import '../sprites/platform.dart';

class PlatformManager extends Component with HasGameRef<JumpNJump> {
  final Random random = Random();
  final List<Platform> items = [];

  final double maxVerticalDistanceToNextPlatform = 350;

  final double minVerticalDistanceToNextPlatform = 200;

  PlatformManager() : super();

  @override
  void onMount() {
    var currentY =
        gameRef.size.y - (random.nextInt(gameRef.size.y.floor()) / 3);

    for (var i = 0;
        i < (gameRef.size.y / minVerticalDistanceToNextPlatform).ceil() + 2;
        i++) {
      if (i != 0) {
        currentY = generateNextY();
      }
      items.add(
        Platform(
          position: Vector2(
            random.nextInt(gameRef.size.x.floor()).toDouble(),
            currentY,
          ),
        ),
      );
    }

    for (var platform in items) {
      add(platform);
    }

    super.onMount();
  }

  double generateNextY() {
    final currentHighestPlatformY = items.last.center.y;
    final distanceToNextY = minVerticalDistanceToNextPlatform.toInt() +
        random
            .nextInt((maxVerticalDistanceToNextPlatform -
                    minVerticalDistanceToNextPlatform)
                .floor())
            .toDouble();

    return currentHighestPlatformY - distanceToNextY;
  }

  @override
  void update(double dt) {
    final topOfLowestPlatform = items.first.position.y;

    final screenBottom = gameRef.camera.position.y + gameRef.size.y;

    if (topOfLowestPlatform > screenBottom) {
      var newPlatY = generateNextY();

      var newPlatX = random.nextInt(gameRef.size.x.floor() - 60).toDouble();
      var newPlat = Platform(position: Vector2(newPlatX, newPlatY));
      while (items.first.position == newPlat.position) {
        newPlat = Platform(position: Vector2(newPlatX, newPlatY));
      }

      add(newPlat);

      items.add(newPlat);

      final lowestPlat = items.removeAt(0);

      lowestPlat.removeFromParent();

      gameRef.gameManager.increaseScore();
    }
    super.update(dt);
  }
}
