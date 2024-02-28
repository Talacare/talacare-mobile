import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/presentation/widgets/game_card.dart';

void main() {
  late Widget gameCard;

  setUp(() {
    gameCard = const MaterialApp(
      home: Scaffold(
        body: GameCard(
          key: Key('game_card'),
          title: 'A Game',
          imgPath: 'puzzle_trailer.png',
        ),
      ),
    );
  });

  testWidgets('Verify the game\'s image is showing', (tester) async {
    await tester.pumpWidget(gameCard);

    final findImage = find.byKey(const Key('game_image'));
    expect(findImage, findsOneWidget,
        reason: 'The game\'s image should be visible');
  });

  testWidgets('Verify the game\'s title is showing', (tester) async {
    await tester.pumpWidget(gameCard);

    final findImage = find.byKey(const Key('game_title'));
    expect(findImage, findsOneWidget,
        reason: 'The game\'s title should be visible');
  });

  testWidgets('Verify the play button is showing', (tester) async {
    await tester.pumpWidget(gameCard);

    final findImage = find.byKey(const Key('play_button'));
    expect(findImage, findsOneWidget,
        reason: 'The play button should be visible');
  });
}
