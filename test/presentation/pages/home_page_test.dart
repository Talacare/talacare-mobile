import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:get_it/get_it.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:provider/provider.dart';
import 'package:talacare/notification_service.dart';
import 'package:talacare/presentation/pages/home_page.dart';
import 'package:mockito/mockito.dart';
import 'package:talacare/presentation/pages/schedule_page.dart';
import 'package:talacare/presentation/pages/story_page.dart';
import 'package:talacare/presentation/providers/auth_provider.dart';
import 'package:talacare/presentation/providers/game_history_provider.dart';
import 'package:talacare/presentation/providers/schedule_provider.dart';
import 'login_page_test.mocks.dart';
import 'package:talacare/presentation/widgets/profile_modal.dart';

import 'schedule_page_test.mocks.dart';
import 'puzzle_page_test.mocks.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  late Widget homePage;
  final getIt = GetIt.instance;

  TestWidgetsFlutterBinding.ensureInitialized();
  setupFirebaseCoreMocks();

  setUp(() async {
    await Firebase.initializeApp();

    getIt.registerLazySingleton(() => AuthProvider(useCase: MockAuthUseCase()));
    getIt.registerLazySingleton(
        () => GameHistoryProvider(useCase: MockGameHistoryUseCase()));
    homePage = const MaterialApp(
      home: HomePage(),
    );
  });

  tearDown(() {
    getIt.unregister<AuthProvider>();
    getIt.unregister<GameHistoryProvider>();
  });

  testWidgets('Verify the greeting text is showing', (tester) async {
    await mockNetworkImagesFor(() => tester.pumpWidget(homePage));

    final findGreeting = find.byKey(const Key('greeting'));
    expect(findGreeting, findsOneWidget,
        reason: 'The greeting text should be visible');
  });

  testWidgets('Verify the user profile picture is showing', (tester) async {
    await mockNetworkImagesFor(() => tester.pumpWidget(homePage));

    final findGreeting = find.byKey(const Key('user_picture'));
    expect(findGreeting, findsOneWidget,
        reason: 'The user profile picture should be visible');
  });

  testWidgets('Verify the Jump N Jump card is showing', (tester) async {
    await mockNetworkImagesFor(() => tester.pumpWidget(homePage));

    final findGreeting = find.byKey(const Key('jump_n_jump_card'));
    expect(findGreeting, findsOneWidget,
        reason: 'The Jump N Jump card should be visible');
  });

  testWidgets('Verify the Puzzle card is showing', (tester) async {
    await mockNetworkImagesFor(() => tester.pumpWidget(homePage));

    final findGreeting = find.byKey(const Key('puzzle_card'));
    expect(findGreeting, findsOneWidget,
        reason: 'The Puzzle card should be visible');
  });

  testWidgets(
      'Verify the Jump n Jump GameCard is working and navigate to Choose Character Page',
      (tester) async {
    final mockObserver = MockNavigatorObserver();

    await mockNetworkImagesFor(
      () => tester.pumpWidget(
        MaterialApp(
          home: const HomePage(),
          navigatorObservers: [mockObserver],
        ),
      ),
    );

    expect(find.byKey(const Key('jump_n_jump_card')), findsOneWidget,
        reason: "Should have jump n jump card");

    await tester.tap(find.byKey(const Key('jump_n_jump_button')));
    await tester.pumpAndSettle();

    expect(find.byType(StoryPage), findsOneWidget);
  });

  testWidgets(
      'Verify the Puzzle GameCard is working and navigate to Puzzle Page',
      (tester) async {
    final mockObserver = MockNavigatorObserver();

    await mockNetworkImagesFor(
      () => tester.pumpWidget(
        MaterialApp(
          home: const HomePage(),
          navigatorObservers: [mockObserver],
        ),
      ),
    );

    expect(find.byKey(const Key('puzzle_card')), findsOneWidget,
        reason: "Shoud have puzzle card");

    await tester.ensureVisible(find.byKey(const Key('puzzle_button')));
    await tester.tap(find.byKey(const Key('puzzle_button')));
    await tester.pumpAndSettle();

    expect(find.byType(StoryPage), findsOneWidget);
  });

  testWidgets('Verify tapping on user picture shows profile modal',
      (tester) async {
    await mockNetworkImagesFor(() => tester.pumpWidget(homePage));
    final userPictureFinder = find.byKey(const Key('user_picture'));
    await tester.tap(userPictureFinder);
    await tester.pumpAndSettle();
    expect(find.byType(ProfileModal), findsOneWidget);
  });

  testWidgets('Verify the schedule button navigates to Schedule Page',
      (tester) async {
    NotificationService().initNotification();
    final mockObserver = MockNavigatorObserver();

    var mockScheduleProvider = MockScheduleProvider();
    const testSchedules = [
      {'id': '1', 'time': '08:00'},
      {'id': '2', 'time': '12:00'},
      {'id': '3', 'time': '18:00'},
    ];
    when(mockScheduleProvider.schedules).thenReturn(testSchedules);
    when(mockScheduleProvider.getSchedulesByUserId()).thenAnswer((_) async {
      return Future.value();
    });
    getIt.registerLazySingleton<ScheduleProvider>(() => mockScheduleProvider);

    await mockNetworkImagesFor(
      () => tester.pumpWidget(ChangeNotifierProvider<ScheduleProvider>(
        create: (_) => mockScheduleProvider,
        child: MaterialApp(
          home: const HomePage(),
          navigatorObservers: [mockObserver],
        ),
      )),
    );

    expect(find.byKey(const Key('schedule_button')), findsOneWidget);

    await tester.ensureVisible(find.byKey(const Key('schedule_button')));
    await tester.tap(find.byKey(const Key('schedule_button')));
    await tester.pumpAndSettle();

    expect(find.byType(SchedulePage), findsOneWidget);
  });
}
