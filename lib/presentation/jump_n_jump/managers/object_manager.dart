import 'dart:math';
import 'package:flame/components.dart';
import '../jump_n_jump.dart';

abstract class ObjectManager<T extends SpriteComponent> extends Component
    with HasGameRef<JumpNJump> {
  final Random random = Random();
  final List<T> items = [];
  double maxVerticalDistanceToNextItem;
  double minVerticalDistanceToNextItem;

  ObjectManager(
      this.maxVerticalDistanceToNextItem, this.minVerticalDistanceToNextItem)
      : super();

  @override
  void onMount() {
    var currentY =
        gameRef.size.y - (random.nextInt(gameRef.size.y.floor()) / 3);

    for (var i = 0;
        i < (gameRef.size.y / minVerticalDistanceToNextItem).ceil() + 2;
        i++) {
      if (i != 0) {
        currentY = generateNextY();
      }
      items.add(
        createItem(
          Vector2(
            random.nextInt(gameRef.size.x.floor()).toDouble(),
            currentY,
          ),
        ),
      );
    }

    for (var item in items) {
      add(item);
    }

    super.onMount();
  }

  double generateNextY() {
    final currentHighestItemY = items.last.center.y;
    final distanceToNextY = minVerticalDistanceToNextItem.toInt() +
        random
            .nextInt(
                (maxVerticalDistanceToNextItem - minVerticalDistanceToNextItem)
                    .floor())
            .toDouble();

    return currentHighestItemY - distanceToNextY;
  }

  T createItem(Vector2 position);

  @override
  void update(double dt) {
    final topOfLowestItem = items.first.position.y;

    final screenBottom = gameRef.camera.position.y + gameRef.size.y;

    if (topOfLowestItem > screenBottom) {
      var newItemY = generateNextY();

      var newItemX = random.nextInt(gameRef.size.x.floor() - 60).toDouble();
      var newItem = createItem(Vector2(newItemX, newItemY));

      while (items.first.position == newItem.position) {
        var newItemX = random.nextInt(gameRef.size.x.floor() - 60).toDouble();
        newItem = createItem(Vector2(newItemX, newItemY));
      }
      add(newItem);
      items.add(newItem);

      final lowestItem = items.removeAt(0);

      lowestItem.removeFromParent();

      increaseScore();
    }
    super.update(dt);
  }

  void increaseScore() {}
}
