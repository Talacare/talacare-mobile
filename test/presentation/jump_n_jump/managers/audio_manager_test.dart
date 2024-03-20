import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:talacare/presentation/jump_n_jump/managers/audio_manager.dart';
import 'package:talacare/presentation/jump_n_jump/wrapper/flame_audio_wrapper.dart';

class MockFlameAudioWrapper extends Mock implements FlameAudioWrapper {}

void main() {
  group('Audio Manager Tests', () {
    late MockFlameAudioWrapper mockFlameAudioWrapper;
    late AudioManager audioManager;

    setUp(() {
      mockFlameAudioWrapper = MockFlameAudioWrapper();
      audioManager = AudioManager(flameAudioWrapper: mockFlameAudioWrapper);
    });

    test('playBackgroundMusic calls FlameAudio.bgm.play with correct file', () {
      const fileName = 'background-music.mp3';
      audioManager.playBackgroundMusic(fileName);
      verify(mockFlameAudioWrapper.playBgm(fileName)).called(1);
    });

    test('stopBackgroundMusic calls FlameAudio.bgm.stop', () {
      audioManager.stopBackgroundMusic();

      verify(mockFlameAudioWrapper.stopBgm()).called(1);
    });
  });
}
