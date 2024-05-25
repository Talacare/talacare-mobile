import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'package:talacare/data/models/image_pair.dart';
import 'package:talacare/data/models/stage_state.dart';
import 'package:talacare/domain/entities/game_history_entity.dart';
import 'package:talacare/presentation/providers/auth_provider.dart';
import 'package:talacare/presentation/providers/game_history_provider.dart';
import 'package:talacare/presentation/puzzle/state/complete_state.dart';
import 'package:talacare/presentation/widgets/next_info.dart';
import 'package:talacare/presentation/puzzle/state/time_left_state.dart';
import 'package:talacare/presentation/puzzle/state/timer_state.dart';


import '../jump_n_jump/jump_n_jump_test.mocks.dart';
import '../pages/login_page_test.mocks.dart';
import 'next_info_test.mocks.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

@GenerateMocks([AudioPlayer])
void main() {
  late List<ImagePair> image;
 
  final getIt = GetIt.instance;
  late MockGameHistoryProvider mockGameHistoryProvider;

  TestWidgetsFlutterBinding.ensureInitialized();
  setupFirebaseCoreMocks();    

  setUp(() async {
    mockGameHistoryProvider = MockGameHistoryProvider();
    await Firebase.initializeApp();

    image = [
      ImagePair("assets/images/puzzle_images/jantung.png", "JANTUNG", "voices/jantung.mp3"),
      ImagePair(
          "assets/images/puzzle_images/kantongdarah.png", "KANTONG DARAH", "voices/kantongdarah.mp3"),
      ImagePair("assets/images/puzzle_images/masker.png", "MASKER", "voices/masker.mp3"),
      ImagePair("assets/images/puzzle_images/perawat.png", "PERAWAT", "voices/perawat.mp3"),
    ];

    when(mockGameHistoryProvider.getHighestScoreHistory('PUZZLE'))
        .thenAnswer((_) async => GameHistoryEntity(
              gameType: 'PUZZLE',
              startTime: DateTime.now(),
              endTime: DateTime.now(),
              score: 75,
            ));

    getIt.registerLazySingleton(() => AuthProvider(useCase: MockAuthUseCase()));

    getIt.registerSingleton<GameHistoryProvider>(mockGameHistoryProvider);

    AudioCache.instance = AudioCache(prefix: 'assets/audio/puzzle/');
  });

  tearDown(() {
    getIt.reset();
  });

  group('Win Puzzle Modal Widget Tests', () {
    testWidgets('Verify All Components are showing', (tester) async {
      await tester.pumpWidget(
        MultiProvider(
            providers: [
              ChangeNotifierProvider<TimerState>(
                create: (context) => TimerState(initialValue: true),
              ),
              ChangeNotifierProvider<CompleteState>(
                create: (context) => CompleteState(initialValue: true),
              ),
              ChangeNotifierProvider<TimeLeftState>(
                create: (context) => TimeLeftState(initialValue: 60),
              ),
            ],
            child: MaterialApp(
              home: Scaffold(
                body: NextInfo(
                  name: "PERAWAT",
                  voice: "voices/perawat.mp3",
                  stageState: StageState([1, 0, 0, 0], 1, 0, image),
                  startTime: DateTime.now(),
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
          home: ChangeNotifierProvider(
            create: (_) => getIt<GameHistoryProvider>(),
            child: MultiProvider(
              providers: [
                ChangeNotifierProvider<TimerState>(
                  create: (context) => TimerState(initialValue: true),
                ),
                ChangeNotifierProvider<CompleteState>(
                  create: (context) => CompleteState(initialValue: true),
                ),
                ChangeNotifierProvider<TimeLeftState>(
                  create: (context) => TimeLeftState(initialValue: 60),
                ),
              ],
              child: MaterialApp(
                home: Scaffold(
                  body: NextInfo(
                    name: "PERAWAT",
                    voice: "voices/perawat.mp3",
                    stageState: StageState([2, 3, 2, 0], 4, 0, image),
                    startTime: DateTime.now(),
                  ),
                ),
              ),
            ),
          ),
          navigatorObservers: [mockObserver],
        ),
      );
      expect(find.byKey(const Key('nextButton')), findsOneWidget);
      await tester.tap(find.byKey(const Key('nextButton')));
      await tester.pumpAndSettle();
    });
  });

  testWidgets('Verify All Components are not showing when not complete',
      (tester) async {
    await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider<TimerState>(
            create: (context) => TimerState(initialValue: true),
          ),
          ChangeNotifierProvider<CompleteState>(
            create: (context) => CompleteState(initialValue: false),
          ),
          ChangeNotifierProvider<TimeLeftState>(
            create: (context) => TimeLeftState(initialValue: 60),
          ),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: NextInfo(
              name: "PERAWAT",
              voice: "voices/perawat.mp3",
              stageState: StageState([1, 0, 0, 0], 1, 0, image),
              startTime: DateTime.now(),
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
        home: ChangeNotifierProvider(
          create: (_) => getIt<GameHistoryProvider>(),
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider<TimerState>(
                create: (context) => TimerState(initialValue: true),
              ),
              ChangeNotifierProvider<CompleteState>(
                create: (context) => CompleteState(initialValue: true),
              ),
              ChangeNotifierProvider<TimeLeftState>(
                create: (context) => TimeLeftState(initialValue: 60),
              ),
            ],
            child: MaterialApp(
              home: Scaffold(
                body: NextInfo(
                  name: "PERAWAT",
                  voice: "voices/perawat.mp3",
                  stageState: StageState([2, 3, 2, 0], 4, 0, image),
                  startTime: DateTime.now(),
                ),
              ),
            ),
          ),
        ),
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
        home: ChangeNotifierProvider(
          create: (_) => getIt<GameHistoryProvider>(),
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider<TimerState>(
                create: (context) => TimerState(initialValue: true),
              ),
              ChangeNotifierProvider<CompleteState>(
                create: (context) => CompleteState(initialValue: true),
              ),
              ChangeNotifierProvider<TimeLeftState>(
                create: (context) => TimeLeftState(initialValue: 60),
              ),
            ],
            child: MaterialApp(
              home: Scaffold(
                body: NextInfo(
                  name: "PERAWAT",
                  voice: "voices/perawat.mp3",
                  stageState: StageState([2, 3, 2, 0], 4, 0, image),
                  startTime: DateTime.now(),
                ),
              ),
            ),
          ),
        ),
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
                create: (context) => TimerState(initialValue: true),
              ),
              ChangeNotifierProvider<CompleteState>(
                create: (context) => CompleteState(initialValue: true),
              ),
              ChangeNotifierProvider<TimeLeftState>(
                create: (context) => TimeLeftState(initialValue: 60),
              ),
            ],
            child: MaterialApp(
              home: Scaffold(
                body: NextInfo(
                  name: "PERAWAT",
                  voice: "voices/perawat.mp3",
                  stageState: StageState([2, 2, 2, 0], 4, 0, image),
                  startTime: DateTime.now(),
                ),
              ),
            )),
      ),
    );

    expect(find.byKey(const Key('nextButton')), findsOneWidget);
    await tester.tap(find.byKey(const Key('nextButton')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('game-over')), findsOneWidget);
    expect(find.text('Selesai'), findsOneWidget);

    await tester.tap(find.text('Selesai'));
    await mockNetworkImagesFor(() => tester.pumpAndSettle());

    expect(find.byKey(const Key('game-over')), findsNothing);
  });

  testWidgets('Verify Score is showing', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MultiProvider(
            providers: [
              ChangeNotifierProvider<TimerState>(
                create: (context) => TimerState(initialValue: true),
              ),
              ChangeNotifierProvider<CompleteState>(
                create: (context) => CompleteState(initialValue: true),
              ),
              ChangeNotifierProvider<TimeLeftState>(
                create: (context) => TimeLeftState(initialValue: 60),
              ),
            ],
            child: MaterialApp(
              home: Scaffold(
                body: NextInfo(
                  name: "PERAWAT",
                  voice: "voices/perawat.mp3",
                  stageState: StageState([2, 2, 2, 0], 4, 0, image),
                  startTime: DateTime.now(),
                ),
              ),
            )),
      ),
    );

    expect(find.byKey(const Key('nextButton')), findsOneWidget);
    await tester.tap(find.byKey(const Key('nextButton')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('game-over')), findsOneWidget);
    expect(find.text('Selesai'), findsOneWidget);

    expect(find.text('110'), findsOneWidget);
  });

  testWidgets('Verify Score is added with time left', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MultiProvider(
            providers: [
              ChangeNotifierProvider<TimerState>(
                create: (context) => TimerState(initialValue: true),
              ),
              ChangeNotifierProvider<CompleteState>(
                create: (context) => CompleteState(initialValue: true),
              ),
              ChangeNotifierProvider<TimeLeftState>(
                create: (context) => TimeLeftState(initialValue: 60),
              ),
            ],
            child: MaterialApp(
              home: Scaffold(
                body: NextInfo(
                  name: "PERAWAT",
                  voice: "voices/perawat.mp3",
                  stageState: StageState([2, 2, 2, 0], 4, 50, image),
                  startTime: DateTime.now(),
                ),
              ),
            )),
      ),
    );

    expect(find.byKey(const Key('nextButton')), findsOneWidget);
    await tester.tap(find.byKey(const Key('nextButton')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('game-over')), findsOneWidget);
    expect(find.text('Selesai'), findsOneWidget);

    expect(find.text('160'), findsOneWidget);
  });

  testWidgets('Verify Lanjut Button is showing when complete', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MultiProvider(
            providers: [
              ChangeNotifierProvider<TimerState>(
                create: (context) => TimerState(initialValue: true),
              ),
              ChangeNotifierProvider<CompleteState>(
                create: (context) => CompleteState(initialValue: true),
              ),
              ChangeNotifierProvider<TimeLeftState>(
                create: (context) => TimeLeftState(initialValue: 60),
              ),
            ],
            child: MaterialApp(
              home: Scaffold(
                body: NextInfo(
                  name: "PERAWAT",
                  voice: "voices/perawat.mp3",
                  stageState: StageState([2, 2, 1, 0], 3, 50, image),
                  startTime: DateTime.now(),
                ),
              ),
            )),
      ),
    );

    expect(find.text('PERAWAT'), findsOneWidget);
    expect(find.text('Lanjut'), findsOneWidget);
    expect(find.byKey(const Key('nextButton')), findsOneWidget);

    await tester.tap(find.byKey(const Key('nextButton')));
    await tester.pumpAndSettle();
  });

  testWidgets('plays bgm.mp3 when PuzzlePage starts', (tester) async {
    final mockPlayer = MockAudioPlayer();

    await tester.pumpWidget(
      MaterialApp(
        home: MultiProvider(
            providers: [
              ChangeNotifierProvider<TimerState>(
                create: (context) => TimerState(initialValue: false),
              ),
              ChangeNotifierProvider<CompleteState>(
                create: (context) => CompleteState(initialValue: false),
              ),
              ChangeNotifierProvider<TimeLeftState>(
                create: (context) => TimeLeftState(initialValue: 60),
              ),
            ],
            child: MaterialApp(
              home: Scaffold(
                body: NextInfo(
                  name: "PERAWAT",
                  voice: "voices/perawat.mp3",
                  stageState: StageState([2, 2, 2, 0], 4, 0, image),
                  audioPlayer: mockPlayer,
                  startTime: DateTime.now(),
                ),
              ),
            )),
      ),
    );

    verify(mockPlayer.play(any)).called(1);
  });

  testWidgets('plays voice after audioPlayer completes playing success.wav',
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
                create: (context) => TimerState(initialValue: false),
              ),
              ChangeNotifierProvider<CompleteState>(
                create: (context) => CompleteState(initialValue: true),
              ),
              ChangeNotifierProvider<TimeLeftState>(
                create: (context) => TimeLeftState(initialValue: 60),
              ),
            ],
            child: MaterialApp(
              home: Scaffold(
                body: NextInfo(
                  name: "PERAWAT",
                  voice: "voices/perawat.mp3",
                  stageState: StageState([2, 2, 2, 0], 4, 0, image),
                  audioPlayer: mockPlayer,
                  startTime: DateTime.now(),
                ),
              ),
            )),
      ),
    );

    await tester.pump();

    verify(mockPlayer.stop()).called(1);
    verify(mockPlayer.play(any)).called(2);
  });

  testWidgets('calls audioPlayer.stop() on dispose', (tester) async {
    final mockPlayer = MockAudioPlayer();

    await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider<TimerState>(
            create: (context) => TimerState(initialValue: false),
          ),
          ChangeNotifierProvider<CompleteState>(
            create: (context) => CompleteState(initialValue: false),
          ),
          ChangeNotifierProvider<TimeLeftState>(
            create: (context) => TimeLeftState(initialValue: 60),
          ),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: NextInfo(
              name: "PERAWAT",
              voice: "voices/perawat.mp3",
              stageState: StageState([1, 0, 0, 0], 1, 0, image),
              audioPlayer: mockPlayer,
              startTime: DateTime.now(),
            ),
          ),
        )));

    final NavigatorState navigator = tester.state(find.byType(Navigator));
    navigator.pop();
    await tester.pumpAndSettle();

    verify(mockPlayer.stop()).called(1);
  });
}
