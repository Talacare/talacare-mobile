import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/presentation/jump_n_jump/wrapper/flame_audio_wrapper.dart';

void main() {
  late FlameAudioWrapper flameAudioWrapper;

  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
    flameAudioWrapper = FlameAudioWrapper();
  });

  testWidgets('playBgm plays background music with correct volume',
      (WidgetTester tester) async {
    const fileName = 'background_music.mp3';
    const volume = 0.5;
    await tester.pumpWidget(MaterialApp(
      home: ElevatedButton(
          child: const Text('test'),
          onPressed: () => flameAudioWrapper.playBgm(fileName, volume)),
    ));

    await tester.tap(find.text('test'));

    await tester.pump();
  });

  testWidgets('stopBgm stops background music',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ElevatedButton(
          child: const Text('test'),
          onPressed: () => flameAudioWrapper.stopBgm()),
    ));

    await tester.tap(find.text('test'));

    await tester.pump();
  });

  testWidgets('playSfx plays sound effects',
      (WidgetTester tester) async {
    const fileName = 'jump_n_jump/game_over.wav';
    await tester.pumpWidget(MaterialApp(
      home: ElevatedButton(
          child: const Text('test'),
          onPressed: () => flameAudioWrapper.playSfx(fileName, 1.0)),
    ));

    await tester.tap(find.text('test'));

    await tester.pump();
  });
}
