import 'dart:math';

import 'package:flame/components.dart';

import '../jump_n_jump.dart';
import '../sprites/platform.dart';

class PlatformManager extends Component with HasGameRef<JumpNJump> {
  final Random random = Random();
  final List<Platform> platforms = [];

  final double maxVerticalDistanceToNextPlatform;

  final double minVerticalDistanceToNextPlatform = 200;

  PlatformManager({required this.maxVerticalDistanceToNextPlatform}) : super();

  @override
  void onMount() {
    var currentY =
        gameRef.size.y - (random.nextInt(gameRef.size.y.floor()) / 3);

    for (var i = 0; i < 9; i++) {
      if (i != 0) {
        currentY = generateNextY();
      }
      platforms.add(
        Platform(
          position: Vector2(
            random.nextInt(gameRef.size.x.floor()).toDouble(),
            currentY,
          ),
        ),
      );
    }

    for (var platform in platforms) {
      add(platform);
    }

    super.onMount();
  }

  double generateNextY() {
    final currentHighestPlatformY = platforms.last.center.y;
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
    final topOfLowestPlatform = platforms.first.position.y;

    final screenBottom = gameRef.dash.position.y +
        (gameRef.size.x / 2) +
        gameRef.screenBufferSpace;

    if (topOfLowestPlatform > screenBottom) {
      var newPlatY = generateNextY();

      var newPlatX = random.nextInt(gameRef.size.x.floor() - 60).toDouble();
      var newPlat = Platform(position: Vector2(newPlatX, newPlatY));
      while (platforms.first.position == newPlat.position) {
        newPlat = Platform(position: Vector2(newPlatX, newPlatY));
      }

      add(newPlat);

      platforms.add(newPlat);

      final lowestPlat = platforms.removeAt(0);

      lowestPlat.removeFromParent();

      gameRef.gameManager.increaseScore();
    }
    super.update(dt);
  }
}
