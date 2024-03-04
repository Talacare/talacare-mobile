import 'package:flutter_tts/flutter_tts.dart';

Future<void> speakText({
  required String text,
  FlutterTts? flutterTts,
}) async {
  flutterTts ??= FlutterTts();

  if (await flutterTts.isLanguageAvailable('id-ID')) {
    await flutterTts.setLanguage('id-ID');
  }

  await flutterTts.setVolume(1.0);
  await flutterTts.setSpeechRate(0.5);
  await flutterTts.setPitch(1.0);

  if (text.isNotEmpty) {
    await flutterTts.speak(text);
  }
}
