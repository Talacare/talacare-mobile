import 'package:talacare/presentation/jump_n_jump/interface/audio_manager_interface.dart';
import 'package:talacare/presentation/jump_n_jump/wrapper/flame_audio_wrapper.dart';

class AudioManager implements IAudioManager {
  final FlameAudioWrapper flameAudioWrapper;

  AudioManager({FlameAudioWrapper? flameAudioWrapper})
      : this.flameAudioWrapper = flameAudioWrapper ?? FlameAudioWrapper();

  @override
  void playBackgroundMusic(String fileName) {
    flameAudioWrapper.playBgm(fileName);
  }

  @override
  void stopBackgroundMusic() {
    flameAudioWrapper.stopBgm();
  }
}
