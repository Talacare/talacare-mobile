import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/presentation/jump_n_jump/jump_n_jump.dart';
import 'package:talacare/core/enums/character_enum.dart';

import '../jump_n_jump_test.mocks.dart';

final jumpNJumpGameTester =
    FlameTester(() => JumpNJump(character: Character.boy));

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.ensureInitialized();
  final mockAudioManager = MockAudioManagerForJumpNJumpTest();
  final jumpNJumpGameTester = FlameTester(() =>
      JumpNJump(character: Character.boy, audioManager: mockAudioManager));

  group('BloodBag Manager Tests', () {
    jumpNJumpGameTester.test('Test number of blood bag generated',
        (game) async {
      expect(game.bloodBagManager.bloodBags.length, equals(2));
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
