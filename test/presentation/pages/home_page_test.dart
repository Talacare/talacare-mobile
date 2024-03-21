import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';

import 'package:network_image_mock/network_image_mock.dart';
import 'package:talacare/presentation/pages/choose_character_page.dart';
import 'package:talacare/presentation/pages/home_page.dart';
import 'package:mockito/mockito.dart';
import 'package:talacare/presentation/pages/puzzle_page.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  late Widget homePage;

  TestWidgetsFlutterBinding.ensureInitialized();
  setupFirebaseCoreMocks();

  setUp(() async {
    await Firebase.initializeApp();

    homePage = const MaterialApp(
      home: HomePage(),
    );
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

    expect(find.byType(ChooseCharacterPage), findsOneWidget);
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

    expect(find.byType(PuzzlePage), findsOneWidget);
  });
}
