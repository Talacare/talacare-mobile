import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/core/enums/character_enum.dart';
import 'package:talacare/presentation/jump_n_jump/jump_n_jump.dart';

final jumpNJumpGameTester =
    FlameTester(() => JumpNJump(character: Character.boy));

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Platform Tests', () {
    jumpNJumpGameTester.test('Test number of platform generated', (game) async {
      expect(game.platformManager.platforms.length, equals(9));
    });

    jumpNJumpGameTester.test('Test Remove and Add Platform', (game) async {
      game.dash.position.y = 0;

      final platformsBeforeUpdate =
          game.platformManager.platforms.first.position;

      game.platformManager.update(0.0);

      final platformsAfterUpdate =
          game.platformManager.platforms.first.position;

      expect(platformsAfterUpdate, isNot(equals(platformsBeforeUpdate)));
    });
  });
}
