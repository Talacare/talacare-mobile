import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:talacare/presentation/pages/home_page.dart';

void main() {
  late Widget homePage;

  setUp(() async {
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
}
