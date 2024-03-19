import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/presentation/jump_n_jump/jump_n_jump.dart';

final jumpNJumpGameTester = FlameTester(
  JumpNJump.new,
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('BloodBag Manager Tests', () {
    jumpNJumpGameTester.test('Test number of blood bag generated',
        (game) async {
      expect(game.bloodBagManager.bloodBags.length, equals(3));
    });

    jumpNJumpGameTester.test('Test Remove and Add Blood Bag', (game) async {
      game.dash.position.y = 0;

      final bloodBagBeforeUpdate =
          game.bloodBagManager.bloodBags.first.position;

      game.bloodBagManager.update(0.0);

      final bloodBagAfterUpdate = game.bloodBagManager.bloodBags.first.position;

      expect(bloodBagAfterUpdate, isNot(equals(bloodBagBeforeUpdate)));
    });
  });
}
