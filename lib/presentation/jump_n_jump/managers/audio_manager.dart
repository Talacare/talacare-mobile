import 'package:talacare/presentation/jump_n_jump/interface/audio_manager_interface.dart';
import 'package:talacare/presentation/jump_n_jump/wrapper/flame_audio_wrapper.dart';

class AudioManager implements IAudioManager {
  final FlameAudioWrapper flameAudioWrapper;

  AudioManager({FlameAudioWrapper? flameAudioWrapper})
      : flameAudioWrapper = flameAudioWrapper ?? FlameAudioWrapper();

  @override
  void playBackgroundMusic(String fileName, double volume) {
    if (fileName.isNotEmpty && volume >= 0) {
      flameAudioWrapper.playBgm(fileName, volume);
    }
  }

  @override
  void stopBackgroundMusic() {
    flameAudioWrapper.stopBgm();
  }

  @override
  void playSoundEffect(String fileName, double volume) {
    if (fileName.isNotEmpty && volume >= 0) {
      flameAudioWrapper.playSfx(fileName, volume);
    }
  }
}
