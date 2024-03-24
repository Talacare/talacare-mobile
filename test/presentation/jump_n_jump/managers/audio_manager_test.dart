import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:talacare/presentation/jump_n_jump/managers/audio_manager.dart';
import 'package:talacare/presentation/jump_n_jump/wrapper/flame_audio_wrapper.dart';

class MockFlameAudioWrapper extends Mock implements FlameAudioWrapper {}

class MockAudioManager extends Mock implements AudioManager {}

void main() {
  group('Audio Manager Tests', () {
    late MockFlameAudioWrapper mockFlameAudioWrapper;
    late AudioManager audioManager;

    setUp(() {
      mockFlameAudioWrapper = MockFlameAudioWrapper();
      audioManager = AudioManager(flameAudioWrapper: mockFlameAudioWrapper);
    });

    test('constructor creates default FlameAudioWrapper if not provided', () {
      final manager = AudioManager();

      expect(manager.flameAudioWrapper, isNotNull);
      expect(manager.flameAudioWrapper, isA<FlameAudioWrapper>());
    });

    test('playBackgroundMusic triggers BGM playback', () {
      const fileName = 'jump_n_jump_bgm.mp3';
      audioManager.playBackgroundMusic(fileName, 1.0);
      verify(mockFlameAudioWrapper.playBgm(fileName, 1.0)).called(1);
    });

    test('stopBackgroundMusic calls stopBgm method on flameAudioWrapper', () {
      audioManager.stopBackgroundMusic();
      verify(mockFlameAudioWrapper.stopBgm()).called(1);
    });

    test('playSoundEffect triggers SFX playback', () {
      const String fileName = 'jump_on_platform.wav';
      audioManager.playSoundEffect(fileName, 1.0);
      verify(mockFlameAudioWrapper.playSfx(fileName, 1.0)).called(1);
    });
  });
}
