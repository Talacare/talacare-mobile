import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Verify the greeting text is showing', (tester) async {
    const homePage = MaterialApp(
      home: HomePage(),
    );

    await tester.pumpWidget(homePage);

    final findGreeting = find.byKey(const Key('greeting'));
    expect(findGreeting, findsOneWidget, reason: 'The greeting text should be visible');
  });

  testWidgets('Verify the user name is showing', (tester) async {
    const homePage = MaterialApp(
      home: HomePage(),
    );

    await tester.pumpWidget(homePage);

    final findGreeting = find.byKey(const Key('user_name'));
    expect(findGreeting, findsOneWidget, reason: 'The user name should be visible');
  });

  testWidgets('Verify the user profile picture is showing', (tester) async {
    const homePage = MaterialApp(
      home: HomePage(),
    );

    await tester.pumpWidget(homePage);

    final findGreeting = find.byKey(const Key('user_picture'));
    expect(findGreeting, findsOneWidget, reason: 'The user profile picture should be visible');
  });

  testWidgets('Verify the Jump N Jump card is showing', (tester) async {
    const homePage = MaterialApp(
      home: HomePage(),
    );

    await tester.pumpWidget(homePage);

    final findGreeting = find.byKey(const Key('jump_n_jump_card'));
    expect(findGreeting, findsOneWidget, reason: 'The Jump N Jump card should be visible');
  });

  testWidgets('Verify the Puzzle card is showing', (tester) async {
    const homePage = MaterialApp(
      home: HomePage(),
    );

    await tester.pumpWidget(homePage);

    final findGreeting = find.byKey(const Key('puzzle_card'));
    expect(findGreeting, findsOneWidget, reason: 'The Puzzle card should be visible');
  });
}
