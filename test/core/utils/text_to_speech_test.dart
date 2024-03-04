import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'text_to_speech_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(const MethodChannel('flutter_tts'),
            (MethodCall methodCall) async {
      if (methodCall.method == 'isLanguageAvailable') {
        return true;
      }
      return null;
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(const MethodChannel('flutter_tts'), null);
  });

  test('speakText completes successfully with a FlutterTts parameter',
      () async {
    final mockFlutterTts = MockFlutterTts();

    when(mockFlutterTts.isLanguageAvailable(any)).thenAnswer((_) async => true);
    when(mockFlutterTts.setLanguage(any)).thenAnswer((_) async {});
    when(mockFlutterTts.setVolume(any)).thenAnswer((_) async {});
    when(mockFlutterTts.setSpeechRate(any)).thenAnswer((_) async {});
    when(mockFlutterTts.setPitch(any)).thenAnswer((_) async {});
    when(mockFlutterTts.speak(any)).thenAnswer((_) async {});

    await speakText(text: "This is a test", flutterTts: mockFlutterTts);

    verify(mockFlutterTts.isLanguageAvailable('id-ID')).called(1);
    verify(mockFlutterTts.setLanguage('id-ID')).called(1);
    verify(mockFlutterTts.setVolume(1.0)).called(1);
    verify(mockFlutterTts.setSpeechRate(0.5)).called(1);
    verify(mockFlutterTts.setPitch(1.0)).called(1);
    verify(mockFlutterTts.speak("This is a test")).called(1);
  });

  test('speakText completes successfully without a FlutterTts parameter',
      () async {
    bool didThrowException = false;
    try {
      await speakText(text: "This is a test");
    } catch (e) {
      didThrowException = true;
    }

    expect(didThrowException, isFalse);
  });
}
