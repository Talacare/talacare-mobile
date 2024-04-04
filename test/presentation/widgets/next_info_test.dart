import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:talacare/data/models/image_pair.dart';
import 'package:talacare/data/models/stage_state.dart';
import 'package:talacare/presentation/providers/auth_provider.dart';
import 'package:talacare/presentation/puzzle/state/complete_state.dart';
import 'package:talacare/presentation/widgets/next_info.dart';
import 'package:provider/provider.dart';
import 'package:talacare/presentation/puzzle/state/timer_state.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../pages/login_page_test.mocks.dart';
import 'next_info_test.mocks.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

@GenerateMocks([AudioPlayer])
void main() {
  late List<ImagePair> image;
  final getIt = GetIt.instance;

  setUp(() async {
    image = [
      ImagePair("assets/images/puzzle_images/jantung.png", "JANTUNG"),
      ImagePair(
          "assets/images/puzzle_images/kantongdarah.png", "KANTONG DARAH"),
      ImagePair("assets/images/puzzle_images/masker.png", "MASKER"),
      ImagePair("assets/images/puzzle_images/perawat.png", "PERAWAT"),
    ];

    getIt.registerLazySingleton(() => AuthProvider(useCase: MockAuthUseCase()));
    AudioCache.instance = AudioCache(prefix: 'assets/audio/puzzle/');
  });

  tearDown(() {
    getIt.unregister<AuthProvider>();
  });

  group('Win Puzzle Modal Widget Tests', () {
    testWidgets('Verify All Components are showing', (tester) async {
      await tester.pumpWidget(
        MultiProvider(
            providers: [
              ChangeNotifierProvider<TimerState>(
                  create: (context) => TimerState(initialValue: true)),
              ChangeNotifierProvider<CompleteState>(
                create: (context) => CompleteState(initialValue: false),
              )
            ],
            child: MaterialApp(
              home: Scaffold(
                body: NextInfo(
                  name: "PERAWAT",
                  stageState: StageState([1, 0, 0, 0], 1, 0, image),
                ),
              ),
            )),
      );

      expect(find.text('PERAWAT'), findsOneWidget);
      expect(find.text('Lanjut'), findsOneWidget);
      expect(find.byKey(const Key('nextButton')), findsOneWidget);
    });

    testWidgets('Button is clickable', (tester) async {
      final mockObserver = MockNavigatorObserver();

      await tester.pumpWidget(
        MaterialApp(
          home: MultiProvider(
              providers: [
                ChangeNotifierProvider<TimerState>(
                    create: (context) => TimerState(initialValue: false)),
                ChangeNotifierProvider<CompleteState>(
                  create: (context) => CompleteState(initialValue: true),
                )
              ],
              child: MaterialApp(
                home: Scaffold(
                  body: NextInfo(
                    name: "PERAWAT",
                    stageState: StageState([1, 0, 0, 0], 1, 0, image),
                  ),
                ),
              )),
          navigatorObservers: [mockObserver],
        ),
      );

      expect(find.byKey(const Key('nextButton')), findsOneWidget);
      await tester.tap(find.byKey(const Key('nextButton')));
      await tester.pumpAndSettle();
    });
  });

  testWidgets('Verify All Components are not showing when timerState is false',
      (tester) async {
    await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider<TimerState>(
              create: (context) => TimerState(initialValue: false)),
          ChangeNotifierProvider<CompleteState>(
            create: (context) => CompleteState(initialValue: false),
          )
        ],
        child: MaterialApp(
          home: Scaffold(
            body: NextInfo(
              name: "PERAWAT",
              stageState: StageState([1, 0, 0, 0], 1, 0, image),
            ),
          ),
        )));

    expect(find.text('PERAWAT'), findsNothing);
    expect(find.text('Lanjut'), findsNothing);
  });

  testWidgets('Verify Game Over modal showing when in 4th stage',
      (tester) async {
    final mockObserver = MockNavigatorObserver();

    await tester.pumpWidget(
      MaterialApp(
        home: MultiProvider(
            providers: [
              ChangeNotifierProvider<TimerState>(
                  create: (context) => TimerState(initialValue: true)),
              ChangeNotifierProvider<CompleteState>(
                create: (context) => CompleteState(initialValue: false),
              )
            ],
            child: MaterialApp(
              home: Scaffold(
                body: NextInfo(
                  name: "PERAWAT",
                  stageState: StageState([2, 3, 2, 0], 4, 0, image),
                ),
              ),
            )),
        navigatorObservers: [mockObserver],
      ),
    );

    expect(find.byKey(const Key('nextButton')), findsOneWidget);
    await tester.tap(find.byKey(const Key('nextButton')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('game-over')), findsOneWidget);
  });

  testWidgets('Verify Game Over modal is clickable on Main Lagi',
      (tester) async {
    final mockObserver = MockNavigatorObserver();

    await tester.pumpWidget(
      MaterialApp(
        home: MultiProvider(
            providers: [
              ChangeNotifierProvider<TimerState>(
                  create: (context) => TimerState(initialValue: true)),
              ChangeNotifierProvider<CompleteState>(
                create: (context) => CompleteState(initialValue: false),
              )
            ],
            child: MaterialApp(
              home: Scaffold(
                body: NextInfo(
                  name: "PERAWAT",
                  stageState: StageState([2, 2, 2, 0], 4, 0, image),
                ),
              ),
            )),
        navigatorObservers: [mockObserver],
      ),
    );

    expect(find.byKey(const Key('nextButton')), findsOneWidget);
    await tester.tap(find.byKey(const Key('nextButton')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('game-over')), findsOneWidget);
    expect(find.text('Main Lagi'), findsOneWidget);

    await tester.tap(find.text('Main Lagi'));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('Image')), findsOneWidget);
  });

  testWidgets('Verify Game Over modal is clickable on Menu', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MultiProvider(
            providers: [
              ChangeNotifierProvider<TimerState>(
                  create: (context) => TimerState(initialValue: true)),
              ChangeNotifierProvider<CompleteState>(
                create: (context) => CompleteState(initialValue: false),
              )
            ],
            child: MaterialApp(
              home: Scaffold(
                body: NextInfo(
                  name: "PERAWAT",
                  stageState: StageState([2, 2, 2, 0], 4, 0, image),
                ),
              ),
            )),
      ),
    );

    expect(find.byKey(const Key('nextButton')), findsOneWidget);
    await tester.tap(find.byKey(const Key('nextButton')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('game-over')), findsOneWidget);
    expect(find.text('Menu'), findsOneWidget);

    await tester.tap(find.text('Menu'));
    await mockNetworkImagesFor(() => tester.pumpAndSettle());

    expect(find.byKey(const Key('greeting')), findsOneWidget);
  });

  testWidgets('Verify Score is showing', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MultiProvider(
            providers: [
              ChangeNotifierProvider<TimerState>(
                  create: (context) => TimerState(initialValue: true)),
              ChangeNotifierProvider<CompleteState>(
                create: (context) => CompleteState(initialValue: false),
              )
            ],
            child: MaterialApp(
              home: Scaffold(
                body: NextInfo(
                  name: "PERAWAT",
                  stageState: StageState([2, 2, 2, 0], 4, 50, image),
                ),
              ),
            )),
      ),
    );

    expect(find.byKey(const Key('nextButton')), findsOneWidget);
    await tester.tap(find.byKey(const Key('nextButton')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('game-over')), findsOneWidget);
    expect(find.text('Menu'), findsOneWidget);

    expect(find.text('50'), findsOneWidget);
  });

  testWidgets('plays bgm.mp3 when PuzzlePage starts', (tester) async {
    final mockPlayer = MockAudioPlayer();

    await tester.pumpWidget(
      MaterialApp(
        home: MultiProvider(
            providers: [
              ChangeNotifierProvider<TimerState>(
                  create: (context) => TimerState(initialValue: false)),
              ChangeNotifierProvider<CompleteState>(
                create: (context) => CompleteState(initialValue: false),
              )
            ],
            child: MaterialApp(
              home: Scaffold(
                body: NextInfo(
                  name: "PERAWAT",
                  stageState: StageState([2, 2, 2, 0], 4, 0, image),
                  audioPlayer: mockPlayer,
                ),
              ),
            )),
      ),
    );

    verify(mockPlayer.play(any)).called(1);
  });

  testWidgets('calls flutterTts.speak after audioPlayer completes',
      (tester) async {
    final mockPlayer = MockAudioPlayer();

    final controller = StreamController<void>();
    controller.add(null);
    when(mockPlayer.onPlayerComplete).thenAnswer((_) => controller.stream);

    await tester.pumpWidget(
      MaterialApp(
        home: MultiProvider(
            providers: [
              ChangeNotifierProvider<TimerState>(
                  create: (context) => TimerState(initialValue: true)),
              ChangeNotifierProvider<CompleteState>(
                create: (context) => CompleteState(initialValue: false),
              )
            ],
            child: MaterialApp(
              home: Scaffold(
                body: NextInfo(
                  name: "PERAWAT",
                  stageState: StageState([2, 2, 2, 0], 4, 0, image),
                  audioPlayer: mockPlayer,
                ),
              ),
            )),
      ),
    );

    await tester.pump();

    verify(mockPlayer.stop()).called(1);
    verify(mockPlayer.play(any)).called(1);
  });

  testWidgets('calls audioPlayer.stop() on dispose', (tester) async {
    final mockPlayer = MockAudioPlayer();

    await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider<TimerState>(
              create: (context) => TimerState(initialValue: false)),
          ChangeNotifierProvider<CompleteState>(
            create: (context) => CompleteState(initialValue: false),
          )
        ],
        child: MaterialApp(
          home: Scaffold(
              body: NextInfo(
            name: "PERAWAT",
            stageState: StageState([1, 0, 0, 0], 1, 0, image),
            audioPlayer: mockPlayer,
          )),
        )));

    await tester.pumpAndSettle();
    await tester.pumpWidget(Container());
    await tester.pumpAndSettle();

    verify(mockPlayer.stop()).called(1);
  });
}
