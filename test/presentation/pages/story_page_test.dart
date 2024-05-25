import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/domain/repositories/game_history_repository.dart';
import 'package:talacare/domain/usecases/game_history_usecase.dart';
import 'package:talacare/injection.dart';
import 'package:talacare/presentation/pages/story_page.dart';
import 'package:talacare/presentation/providers/game_history_provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talacare/presentation/widgets/home_button.dart';

import '../../domain/usecases/game_history_usecase_test.mocks.dart';
import 'puzzle_page_test.mocks.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class FakeRoute extends Fake implements Route<dynamic> {}

void main() {
  late MockNavigatorObserver mockObserver;
  late MockGameHistoryUseCase mockGameHistoryUseCase;
  late MockGameHistoryRepository mockGameHistoryRepository;
  late MockGameHistoryProvider mockGameHistoryProvider;

  setUpAll(() {
    registerFallbackValue(FakeRoute());
    mockGameHistoryUseCase = MockGameHistoryUseCase();
    mockGameHistoryRepository = MockGameHistoryRepository();
    mockGameHistoryProvider = MockGameHistoryProvider();
    mockObserver = MockNavigatorObserver();

    getIt.registerSingleton<GameHistoryUseCase>(mockGameHistoryUseCase);
    getIt.registerSingleton<GameHistoryRepository>(mockGameHistoryRepository);
    getIt.registerSingleton<GameHistoryProvider>(mockGameHistoryProvider);
  });

  Widget createTestableWidget(String storyType) {
    return MaterialApp(
      home: StoryPage(storyType: storyType),
      navigatorObservers: [mockObserver],
    );
  }

  group('StoryPage', () {
    late NavigatorObserver mockObserver;

    setUp(() {
      mockObserver = MockNavigatorObserver();
    });

    testWidgets('Home button should be tappable on Puzzle Start Story Page',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget('PUZZLE Start'));
      expect(find.byType(HomeButton), findsOneWidget);
      await tester.tap(find.byType(HomeButton));
      await tester.pumpAndSettle();
    });

    testWidgets('Home button should be tappable on Puzzle Ending Story Page',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget('PUZZLE Ending'));
      expect(find.byType(HomeButton), findsOneWidget);
      await tester.tap(find.byType(HomeButton));
      await tester.pumpAndSettle();
    });

    testWidgets(
        'displays the correct number of gifs on Puzzle Start Story Page',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget('PUZZLE Start'));
      expect(find.byType(Image), findsAtLeast(1));
    });

    testWidgets(
        'displays the correct number of gifs on Puzzle Ending Story Page',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget('PUZZLE Ending'));
      expect(find.byType(Image), findsAtLeast(1));
    });

    testWidgets('displays the correct gif on Puzzle Start Story Page',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget('PUZZLE Start'));
      expect(
          find.byWidgetPredicate((widget) =>
              widget is Image &&
              widget.image ==
                  const AssetImage(
                      'assets/images/story/puzzle/start/story0.gif')),
          findsOneWidget);
    });

    testWidgets('displays the correct gif on Puzzle Start Ending Story Page',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget('PUZZLE Ending'));
      expect(
          find.byWidgetPredicate((widget) =>
              widget is Image &&
              widget.image ==
                  const AssetImage(
                      'assets/images/story/puzzle/end/story0.gif')),
          findsOneWidget);
    });

    testWidgets('displays the correct gif count for Puzzle Start Story Page',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget('PUZZLE Start'));
      expect(find.text('1/3'), findsOneWidget);
    });

    testWidgets('displays the correct gif count for Puzzle Ending Story Page',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget('PUZZLE Ending'));
      expect(find.text('1/2'), findsOneWidget);
    });

    testWidgets(
        'correctly updates gif count on button press for Puzzle Start Story Page',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget('PUZZLE Start'));
      await tester.tap(find.text('Lanjut'));
      await tester.pump();
      expect(find.text('2/3'), findsOneWidget);
    });

    testWidgets(
        'correctly updates gif count on button press for Puzzle Ending Story Page',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget('PUZZLE Ending'));

      await tester.tap(find.text('Lanjut'));
      await tester.pump();

      expect(find.text('2/2'), findsOneWidget);
    });

    testWidgets(
        'skip button disappears on last gif for Puzzle Start Story Page',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget('PUZZLE Start'));
      await tester.tap(find.text('Lanjut'));
      await tester.pump();
      await tester.tap(find.text('Lanjut'));
      await tester.pump();
      expect(find.text('Lewati'), findsNothing);
    });

    testWidgets(
        'skip button disappears on last gif for Puzzle Start Ending Page',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget('PUZZLE Ending'));
      await tester.tap(find.text('Lanjut'));
      await tester.pump();
      expect(find.text('Lewati'), findsNothing);
    });

    testWidgets(
        'last gif displays "Mainkan" for non-ending Puzzle Start Story Page',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget('PUZZLE Start'));
      await tester.tap(find.text('Lanjut'));
      await tester.pump();
      await tester.tap(find.text('Lanjut'));
      await tester.pump();
      expect(find.text('Mainkan'), findsOneWidget);
    });

    testWidgets(
        'last gif displays "Selesai" for ending Puzzle Ending Story Page',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget('PUZZLE Ending'));
      await tester.tap(find.text('Lanjut'));
      await tester.pump();
      expect(find.text('Selesai'), findsOneWidget);
    });

    testWidgets(
        'home button should be tappable and navigate to root for Puzzle Start Story Page',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget('PUZZLE Start'));
      expect(find.byType(HomeButton), findsOneWidget);
      await tester.tap(find.byType(HomeButton));
      await tester.pumpAndSettle();

      verifyNever(() => mockObserver.didPush(any(), any()));
    });

    testWidgets(
        'home button should be tappable and navigate to root for Puzzle Ending Story Page',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: const StoryPage(storyType: 'PUZZLE Ending'),
        navigatorObservers: [mockObserver],
      ));

      expect(find.byType(HomeButton), findsOneWidget);
      await tester.tap(find.byType(HomeButton));
      await tester.pumpAndSettle();

      verify(() => mockObserver.didPush(any(), any())).called(1);
    });

    testWidgets(
        'finishes story without "Lewati" button for Puzzle Ending Story Page',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: const StoryPage(storyType: 'PUZZLE Ending'),
        navigatorObservers: [mockObserver],
      ));
      expect(find.text('Lewati'), findsNothing);
    });

    testWidgets(
        'finishes story and navigates accordingly for ending Puzzle Start Ending Page',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: const StoryPage(storyType: 'PUZZLE Ending'),
        navigatorObservers: [mockObserver],
      ));
      await tester.tap(find.text('Lanjut'));
      await tester.pump();
      await tester.tap(find.text('Selesai'));
      await tester.pumpAndSettle();

      verify(() => mockObserver.didPush(any(), any())).called(1);
    });

    testWidgets(
        'finishes story and navigates to new page for non-ending Puzzle Start Story Page',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget('PUZZLE Start'));
      await tester.tap(find.text('Lanjut'));
      await tester.pump();
      await tester.tap(find.text('Lanjut'));
      await tester.pump();
      await tester.tap(find.text('Mainkan'));
      await tester.pump();
      verifyNever(() => mockObserver.didPush(any(), any()));
    });
  });
}
