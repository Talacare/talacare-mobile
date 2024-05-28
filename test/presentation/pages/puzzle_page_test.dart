import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:talacare/data/models/stage_state.dart';
import 'package:talacare/domain/entities/game_history_entity.dart';
import 'package:talacare/domain/repositories/game_history_repository.dart';
import 'package:talacare/domain/usecases/game_history_usecase.dart';
import 'package:talacare/injection.dart';
import 'package:talacare/presentation/pages/puzzle_page.dart';
import 'package:talacare/presentation/providers/game_history_provider.dart';

import '../../domain/usecases/game_history_usecase_test.mocks.dart';
import 'puzzle_page_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GameHistoryProvider>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<GetIt>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<GameHistoryUseCase>(onMissingStub: OnMissingStub.returnDefault)
])
void main() {
  late Widget puzzlePage;
  late MockGameHistoryUseCase mockGameHistoryUseCase;
  late MockGameHistoryRepository mockGameHistoryRepository;
  late MockGameHistoryProvider mockGameHistoryProvider;

  setUp(() async {
    mockGameHistoryUseCase = MockGameHistoryUseCase();
    mockGameHistoryRepository = MockGameHistoryRepository();
    mockGameHistoryProvider = MockGameHistoryProvider();

    when(mockGameHistoryProvider.getHighestScoreHistory('PUZZLE'))
        .thenAnswer((_) async => GameHistoryEntity(
              gameType: 'PUZZLE',
              startTime: DateTime.now(),
              endTime: DateTime.now(),
              score: 75,
            ));

    getIt.registerSingleton<GameHistoryUseCase>(mockGameHistoryUseCase);
    getIt.registerSingleton<GameHistoryRepository>(mockGameHistoryRepository);
    getIt.registerSingleton<GameHistoryProvider>(mockGameHistoryProvider);

    puzzlePage = MaterialApp(
        home: PuzzlePage(
          stageState: StageState([1, 0, 0, 0], 1, 0, []),
    ));
  });

  tearDown(() {
    getIt.reset();
  });

  group('Puzzle Page Tests', () {
    testWidgets('Check if time left is showing', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(puzzlePage);
        await tester.pumpAndSettle();

        final findWaktu = find.text('SISA WAKTU');
        expect(findWaktu, findsOneWidget,
            reason: 'Time left should be visible');
      });
    });

    testWidgets('Check if score is showing', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(puzzlePage);
        await tester.pumpAndSettle();

        final findSkor = find.text('🏆');
        expect(findSkor, findsOneWidget, reason: 'Score should be visible');
      });
    });

    testWidgets('Check if images is showing', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(puzzlePage);
        await tester.pumpAndSettle();

        expect(find.byKey(const Key("Image")), findsOneWidget,
            reason: 'Image should be visible');
      });
    });

    testWidgets('Check if next button is showing', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(puzzlePage);
        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 60));

        final findLanjut = find.byKey(const Key('nextButton'));
        expect(findLanjut, findsOneWidget,
            reason: 'Next button should be visible');
      });
    });

    testWidgets('Check if pause button is showing', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(puzzlePage);
        await tester.pumpAndSettle();

        final findLanjut = find.byKey(const Key('pause_button'));
        expect(findLanjut, findsOneWidget,
            reason: 'Pause button should be visible');
      });
    });

    testWidgets('Check lanjutkan pause button is working', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(puzzlePage);
        await tester.pumpAndSettle(const Duration(seconds: 30));

        await tester.tap(find.byKey(const Key('pause_button')));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Lanjutkan'));
        await tester.pumpAndSettle(const Duration(seconds: 30));

        expect(find.text('0'), findsOneWidget);
      });
    });

    testWidgets('Check akhiri pause button is working', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(puzzlePage);
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key('pause_button')));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Akhiri'));
        await tester.pumpAndSettle();
      });
    });
  });
}
