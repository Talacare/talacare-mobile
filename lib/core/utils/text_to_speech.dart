import 'package:flutter_tts/flutter_tts.dart';

Future<void> speakText({
  required String text,
  FlutterTts? flutterTts,
}) async {
  flutterTts ??= FlutterTts();
  String language = 'id-ID';
  double volume = 1.0;
  double rate = 0.5;
  double pitch = 1.0;

  if (await flutterTts.isLanguageAvailable(language)) {
    await flutterTts.setLanguage(language);
  }

  await flutterTts.setVolume(volume);
  await flutterTts.setSpeechRate(rate);
  await flutterTts.setPitch(pitch);

  if (text.isNotEmpty) {
    await flutterTts.speak(text);
  }
}
