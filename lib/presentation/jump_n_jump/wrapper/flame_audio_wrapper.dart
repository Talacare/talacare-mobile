import 'package:flame_audio/flame_audio.dart';

class FlameAudioWrapper {
  void playBgm(String fileName, {double volume = 0.5}) {
    FlameAudio.bgm.play(fileName, volume: volume);
  }

  void stopBgm() {
    FlameAudio.bgm.stop();
  }
}
