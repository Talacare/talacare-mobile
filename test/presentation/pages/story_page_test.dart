import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/domain/repositories/game_history_repository.dart';
import 'package:talacare/domain/usecases/game_history_usecase.dart';
import 'package:talacare/injection.dart';
import 'package:talacare/presentation/pages/story_page.dart';
import 'package:talacare/presentation/providers/game_history_provider.dart';
import 'package:talacare/presentation/widgets/button.dart';
import 'package:mocktail/mocktail.dart';

import '../../domain/usecases/game_history_usecase_test.mocks.dart';
import 'puzzle_page_test.mocks.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class FakeRoute extends Fake implements Route<dynamic> {}

void main() {
  late MockGameHistoryUseCase mockGameHistoryUseCase;
  late MockGameHistoryRepository mockGameHistoryRepository;
  late MockGameHistoryProvider mockGameHistoryProvider;

  setUpAll(() {
    registerFallbackValue(FakeRoute());
    mockGameHistoryUseCase = MockGameHistoryUseCase();
    mockGameHistoryRepository = MockGameHistoryRepository();
    mockGameHistoryProvider = MockGameHistoryProvider();

    getIt.registerSingleton<GameHistoryUseCase>(mockGameHistoryUseCase);
    getIt.registerSingleton<GameHistoryRepository>(mockGameHistoryRepository);
    getIt.registerSingleton<GameHistoryProvider>(mockGameHistoryProvider);
  });
  group('StoryPage', () {
    late NavigatorObserver mockObserver;

    setUp(() {
      mockObserver = MockNavigatorObserver();
    });

    testWidgets('home button should be tappable', (WidgetTester tester) async {
      await tester
          .pumpWidget(const MaterialApp(home: StoryPage(storyType: 'test')));

      expect(find.byType(IconButton), findsOneWidget);
      await tester.tap(find.byType(IconButton));
      await tester.pump();
    });

    testWidgets('displays the correct number of gifs',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(const MaterialApp(home: StoryPage(storyType: 'test')));
      expect(find.byType(Image), findsAtLeast(1));
    });

    testWidgets('displays the correct gif', (WidgetTester tester) async {
      await tester
          .pumpWidget(const MaterialApp(home: StoryPage(storyType: 'test')));
      expect(
          find.byWidgetPredicate((widget) =>
              widget is Image &&
              widget.image ==
                  const AssetImage(
                      'assets/images/story/jump_n_jump/start/story0.gif')),
          findsOneWidget);
    });

    testWidgets('displays the correct gif count', (WidgetTester tester) async {
      await tester
          .pumpWidget(const MaterialApp(home: StoryPage(storyType: 'test')));
      expect(find.text('1/2'), findsOneWidget);
    });

    testWidgets('correctly updates gif count on button press',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(const MaterialApp(home: StoryPage(storyType: 'test')));

      await tester.tap(find.text('Lanjut'));
      await tester.pump();

      expect(find.text('2/2'), findsOneWidget);
    });

    testWidgets('displays the skip button when not on the last gif',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(const MaterialApp(home: StoryPage(storyType: 'test')));
      expect(find.text('Lewati'), findsOneWidget);
    });

    testWidgets('skip button has the correct width',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(const MaterialApp(home: StoryPage(storyType: 'test')));

      final buttonFinder = find.widgetWithText(Button, 'Lewati');
      expect(buttonFinder, findsOneWidget);

      final button = tester.widget<Button>(buttonFinder);
      expect(button.width, equals(120));
    });

    testWidgets('skip button disappears on last gif',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(const MaterialApp(home: StoryPage(storyType: 'test')));
      await tester.tap(find.text('Lanjut'));
      await tester.pump();
      expect(find.text('Lewati'), findsNothing);
    });

    testWidgets('last gif displays "Mainkan" for non-ending story type',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(const MaterialApp(home: StoryPage(storyType: 'test')));
      await tester.tap(find.text('Lanjut'));
      await tester.pump();
      expect(find.text('Mainkan'), findsOneWidget);
    });

    testWidgets('last gif displays "Selesai" for ending story type',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(const MaterialApp(home: StoryPage(storyType: 'Ending')));
      await tester.tap(find.text('Lanjut'));
      await tester.pump();
      expect(find.text('Selesai'), findsOneWidget);
    });

    testWidgets('home button should be tappable and navigate to root',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: const StoryPage(storyType: 'test'),
        navigatorObservers: [mockObserver],
      ));

      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      verify(() => mockObserver.didPush(any(), any())).called(1);
    });

    testWidgets(
        'finishes story and navigates accordingly for ending story type',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: const StoryPage(storyType: 'Ending'),
        navigatorObservers: [mockObserver],
      ));
      await tester.tap(find.text('Lewati'));
      await tester.pumpAndSettle();

      verify(() => mockObserver.didPush(any(), any())).called(1);
    });

    testWidgets(
        'finishes story and navigates accordingly for ending story type',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: const StoryPage(storyType: 'Ending'),
        navigatorObservers: [mockObserver],
      ));
      await tester.tap(find.text('Lanjut'));
      await tester.pump();
      await tester.tap(find.text('Selesai'));
      await tester.pumpAndSettle();

      verify(() => mockObserver.didPush(any(), any())).called(1);
    });

    testWidgets(
        'finishes story and navigates to new page for non-ending story type',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: const StoryPage(storyType: 'test'),
        navigatorObservers: [mockObserver],
      ));

      await tester.tap(find.text('Lanjut'));
      await tester.pump();
      await tester.tap(find.text('Mainkan'));
      await tester.pump();

      verify(() => mockObserver.didPush(any(), any())).called(2);
    });
  });
}
