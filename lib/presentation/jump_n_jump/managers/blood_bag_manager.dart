import 'dart:math';

import 'package:flame/components.dart';
import 'package:talacare/presentation/jump_n_jump/sprites/sprites.dart';
import '../jump_n_jump.dart';
import '../sprites/blood_bag.dart';

class BloodBagManager extends Component with HasGameRef<JumpNJump> {
  final Random random = Random();
  final List<BloodBag> bloodBags = [];

  final double maxVerticalDistanceToNextBloodBag = 1000;

  final double minVerticalDistanceToNextBloodBag = 600;

  BloodBagManager() : super();

  @override
  void onMount() {
    var currentY =
        gameRef.size.y - (random.nextInt(gameRef.size.y.floor()) / 3);

    for (var i = 0;
        i < (gameRef.size.y / minVerticalDistanceToNextBloodBag).ceil() + 2;
        i++) {
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

    return currentHighestBloodBagY - distanceToNextY;
  }

  @override
  void update(double dt) {
    final topOfLowestBloodBag = bloodBags.first.position.y;

    final screenBottom = gameRef.camera.position.y + gameRef.size.y;

    if (topOfLowestBloodBag > screenBottom) {
      var newBloodBagY = generateNextY();

      var newBloodBagX = random.nextInt(gameRef.size.x.floor() - 60).toDouble();
      var newBloodBag = BloodBag(position: Vector2(newBloodBagX, newBloodBagY));

      while (bloodBags.first.position == newBloodBag.position) {
        var newBloodBagY = generateNextY();
        var newBloodBagX =
            random.nextInt(gameRef.size.x.floor() - 60).toDouble();
        newBloodBag = BloodBag(position: Vector2(newBloodBagX, newBloodBagY));
      }
      add(newBloodBag);
      bloodBags.add(newBloodBag);

      final lowestBloodBag = bloodBags.removeAt(0);

      lowestBloodBag.removeFromParent();
    }
    super.update(dt);
  }
}
