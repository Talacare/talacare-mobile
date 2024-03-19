import 'dart:math';

import 'package:flame/components.dart';
import 'package:talacare/presentation/jump_n_jump/sprites/sprites.dart';
import '../jump_n_jump.dart';
import '../sprites/blood_bag.dart';

class BloodBagManager extends Component with HasGameRef<JumpNJump> {
  final Random random = Random();
  final List<BloodBag> bloodBags = [];

  final double maxVerticalDistanceToNextBloodBag;

  final double minVerticalDistanceToNextBloodBag = 300;

  BloodBagManager({required this.maxVerticalDistanceToNextBloodBag}) : super();

  @override
  void onMount() {
    var currentY =
        gameRef.size.y - (random.nextInt(gameRef.size.y.floor()) / 3);

    for (var i = 0; i < 2; i++) {
      if (i != 0) {
        currentY = generateNextY();
      }
      bloodBags.add(
        BloodBag(
          position: Vector2(
            random.nextInt(gameRef.size.x.floor()).toDouble(),
            currentY,
          ),
        ),
      );
    }

    for (var bloodBag in bloodBags) {
      add(bloodBag);
    }

    super.onMount();
  }

  double generateNextY() {
    final currentHighestBloodBagY = bloodBags.last.center.y;
    final distanceToNextY = minVerticalDistanceToNextBloodBag.toInt() +
        random
            .nextInt((maxVerticalDistanceToNextBloodBag -
                    minVerticalDistanceToNextBloodBag)
                .floor())
            .toDouble();

    return currentHighestBloodBagY - 2 * distanceToNextY;
  }

  @override
  void update(double dt) {
    final topOfLowestBloodBag = bloodBags.first.position.y;

    final screenBottom = gameRef.dash.position.y +
        (gameRef.size.x / 2) +
        gameRef.screenBufferSpace;

    if (topOfLowestBloodBag > screenBottom) {
      var newBloodBagY = generateNextY();

      var newBloodBagX = random.nextInt(gameRef.size.x.floor() - 60).toDouble();
      final newBloodBag =
          BloodBag(position: Vector2(newBloodBagX, newBloodBagY));
      add(newBloodBag);

      bloodBags.add(newBloodBag);

      final lowestBloodBag = bloodBags.removeAt(0);

      lowestBloodBag.removeFromParent();

      // gameRef.gameManager.increaseScore();
    }
    super.update(dt);
  }
}
