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

  group('Food Manager Tests', () {
    jumpNJumpGameTester.test('Test number of food generated',
        (game) async {
      expect(game.foodManager.items.length, equals(4));
    });

    jumpNJumpGameTester.test('Test Remove and Add Food', (game) async {
      game.dash.position.y = 0;

      final foodBeforeUpdate =
          game.foodManager.items.first.position;
      
      game.dash.jump();
      game.update(0.1);
      game.update(0.1);
      game.update(0.1);

      final foodAfterUpdate = game.foodManager.items.first.position;

      expect(foodAfterUpdate, isNot(equals(foodBeforeUpdate)));
    });
  });
}
