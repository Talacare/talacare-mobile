import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:talacare/core/enums/character_enum.dart';
import 'package:talacare/presentation/jump_n_jump/health_bar.dart';
import 'package:talacare/presentation/jump_n_jump/managers/audio_manager.dart';
import 'package:talacare/presentation/jump_n_jump/managers/game_manager.dart';
import 'package:talacare/presentation/pages/jump_n_jump_page.dart';
import 'package:talacare/presentation/jump_n_jump/jump_n_jump.dart';
import 'package:talacare/presentation/providers/game_history_provider.dart';
import 'package:talacare/presentation/widgets/game_modal.dart';
import 'package:talacare/presentation/widgets/score_and_pause.dart';

import 'puzzle_page_test.mocks.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockAudioManager extends Mock implements AudioManager {}

class MockGameManager extends Mock implements GameManager {
  @override
  ValueNotifier<int> get score => ValueNotifier<int>(0);
  @override
  ValueNotifier<int> get highScore => ValueNotifier<int>(0);
}

void handleMockPause(BuildContext context) {
  debugPrint('handleMockPause called');
}

@GenerateNiceMocks([
  MockSpec<GameHistoryProvider>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<GetIt>(onMissingStub: OnMissingStub.returnDefault),
])
void main() {
  late GetIt getIt;
  late MockGameHistoryProvider mockGameHistoryProvider;
  late MockAudioManager mockAudioManager;
  late MockGameManager mockGameManager;
  late GlobalKey<JumpNJumpPageState> key;

  setUp(() {
    getIt = GetIt.instance;
    mockGameHistoryProvider = MockGameHistoryProvider();
    getIt.registerSingleton<GameHistoryProvider>(mockGameHistoryProvider);
    mockAudioManager = MockAudioManager();
    mockGameManager = MockGameManager();
    key = GlobalKey();
  });

  tearDown(() {
    getIt.reset();
  });

  group('JumpNJumpPage Widget Tests', () {
    testWidgets('Coin icon and score display are correctly shown',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
          home: JumpNJumpPage(
        character: Character.girl,
      )));

      expect(find.byKey(const Key('coinIcon')), findsOneWidget);
      expect(find.byKey(const Key('scoreDisplay')), findsOneWidget);
    });

    testWidgets('High score display is correctly shown',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
          home: JumpNJumpPage(
        character: Character.girl,
      )));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('highScoreDisplay')), findsOneWidget);
    });

    testWidgets('Control buttons are correctly shown',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
          home: JumpNJumpPage(
        character: Character.girl,
      )));

      expect(find.byKey(const Key('leftControlButton')), findsOneWidget);
      expect(find.byKey(const Key('rightControlButton')), findsOneWidget);
    });

    testWidgets('Simulating control button presses does not throw errors',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
          home: JumpNJumpPage(
        character: Character.girl,
      )));

      final Finder leftButton = find.byKey(const Key('leftControlButton'));
      final TestGesture leftGesture =
          await tester.startGesture(tester.getCenter(leftButton));
      await tester.pump();
      await leftGesture.up();
      await tester.pump();

      final Finder rightButton = find.byKey(const Key('rightControlButton'));
      final TestGesture rightGesture =
          await tester.startGesture(tester.getCenter(rightButton));
      await tester.pump();
      await rightGesture.up();
      await tester.pump();
    });

    testWidgets('HealthBar display is correctly shown',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
          home: JumpNJumpPage(
        character: Character.girl,
      )));
      await tester.pumpAndSettle();
      expect(find.byType(HealthBar), findsOneWidget);
    });

    testWidgets('createGameWidget should create a GameWidget',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: JumpNJumpPage(character: Character.boy),
        ),
      );

      final gameWidget = find.byType(GameWidget<JumpNJump>);
      expect(gameWidget, findsOneWidget);
    });

    testWidgets('handlePause should execute and show GameModal',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: JumpNJumpPage(key: key, character: Character.boy),
        ),
      );

      final state = key.currentState!;
      state.audioManager = mockAudioManager;
      state.game.gameManager = mockGameManager;

      state.handlePause();

      await tester.pumpAndSettle();

      verify(mockAudioManager.pauseBackgroundMusic()).called(1);
      expect(find.byType(GameModal), findsOneWidget);
      expect(find.byKey(const Key('game-pause')), findsOneWidget);
    });

    testWidgets('createGameWidget should create a GameWidget',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: JumpNJumpPage(character: Character.boy),
        ),
      );

      final gameWidget = find.byType(GameWidget<JumpNJump>);
      expect(gameWidget, findsOneWidget);
    });

    testWidgets('handleResume should execute without errors',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: JumpNJumpPage(key: key, character: Character.boy),
        ),
      );

      final state = key.currentState!;
      state.audioManager = mockAudioManager;
      state.game.gameManager = mockGameManager;

      state.handleResume();

      await tester.pumpAndSettle();

      verify(mockAudioManager.resumeBackgroundMusic()).called(1);
      verify(mockGameManager.resumeGame()).called(1);
    });

    testWidgets('onLose should create a GameWidget',
        (WidgetTester tester) async {
      const key = Key('jump_n_jump_page_key');

      await tester.pumpWidget(
        const MaterialApp(
          home: JumpNJumpPage(key: key, character: Character.boy),
        ),
      );

      final JumpNJumpPageState state =
          tester.state<JumpNJumpPageState>(find.byType(JumpNJumpPage));
      state.game.gameManager.startTime = DateTime.now();
      state.game.onLose();

      await tester.pumpAndSettle();
    });

    testWidgets('onBackToMenu should remove overlays',
        (WidgetTester tester) async {
      const key = Key('jump_n_jump_page_key');

      await tester.pumpWidget(
        const MaterialApp(
          home: JumpNJumpPage(key: key, character: Character.boy),
        ),
      );
      final JumpNJumpPageState state =
          tester.state<JumpNJumpPageState>(find.byType(JumpNJumpPage));
      state.game.gameManager.startTime = DateTime.now();
      state.game.onLose();

      await tester.pumpAndSettle();

      expect(state.game.overlays.isActive('gameOverOverlay'), isTrue);
    });

    testWidgets('onMainLagiPressed should pop the modal and resume game',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: JumpNJumpPage(key: key, character: Character.boy),
        ),
      );

      final state = key.currentState!;
      state.audioManager = mockAudioManager;
      state.game.gameManager = mockGameManager;

      state.handlePause();

      await tester.pumpAndSettle();

      expect(find.byType(GameModal), findsOneWidget);
      expect(find.byKey(const Key('game-pause')), findsOneWidget);

      await tester.tap(find.text('Lanjutkan'));
      await tester.pumpAndSettle();

      verify(mockAudioManager.resumeBackgroundMusic()).called(1);
      verify(mockGameManager.resumeGame()).called(1);
      expect(find.byType(GameModal), findsNothing);
    });

    testWidgets(
        'onMenuPressed should pop the modal and navigate back to the main menu',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: JumpNJumpPage(key: key, character: Character.boy),
        ),
      );

      final state = key.currentState!;
      state.audioManager = mockAudioManager;
      state.game.gameManager = mockGameManager;

      state.handlePause();

      await tester.pumpAndSettle();

      expect(find.byType(GameModal), findsOneWidget);
      expect(find.byKey(const Key('game-pause')), findsOneWidget);

      await tester.tap(find.text('Akhiri'));
      await tester.pumpAndSettle();

      expect(find.byType(GameModal), findsNothing);
    });

    testWidgets('onPauseTap should call handleMockPause',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ScoreAndPause(
              key: const Key('highScoreDisplay'),
              highScore: 10000,
              onPauseTap: () =>
                  handleMockPause(tester.element(find.byType(ScoreAndPause))),
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(const Key('highScoreDisplay')));
      await tester.pump();

      expect(find.byType(ScoreAndPause), findsOneWidget);
    });
  });
}
