import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:talacare/presentation/jump_n_jump/interface/audio_manager_interface.dart';
import 'package:talacare/core/enums/character_enum.dart';
import 'package:talacare/presentation/jump_n_jump/jump_n_jump.dart';
import 'platform_manager_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<IAudioManager>(as: #MockAudioManagerForPlatformTest),
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final mockAudioManager = MockAudioManagerForPlatformTest();

  final jumpNJumpGameTester = FlameTester(() =>
      JumpNJump(character: Character.boy, audioManager: mockAudioManager));

  group('Platform Tests', () {
    jumpNJumpGameTester.test('Test number of platform generated', (game) async {
      expect(game.platformManager.platforms.length, equals(5));
    });

    jumpNJumpGameTester.test('Test Remove and Add Platform', (game) async {
      game.dash.position.y = 0;

      final platformsBeforeUpdate =
          game.platformManager.platforms.first.position;
      
      game.dash.jump();
      game.update(0.1);
      game.update(0.1);
      game.update(0.1);

      final platformsAfterUpdate =
          game.platformManager.platforms.first.position;

      expect(platformsAfterUpdate, isNot(equals(platformsBeforeUpdate)));
    });
  });
}
