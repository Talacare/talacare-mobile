import 'package:flame_audio/flame_audio.dart';

class FlameAudioWrapper {
  void playBgm(String fileName, double volume) {
    FlameAudio.bgm.play(fileName, volume: volume);
  }

  void stopBgm() {
    FlameAudio.bgm.stop();
  }

  void playSfx(String fileName, double volume) {
    FlameAudio.play(fileName);
  }

  void pauseBgm() {
    FlameAudio.bgm.pause();
  }

  void resumeBgm() {
    FlameAudio.bgm.resume();
  }
}
