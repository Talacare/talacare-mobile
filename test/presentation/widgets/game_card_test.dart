import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('Verify the game\'s image is showing', (tester) async {
    const gameCard = MaterialApp(
      home: GameCard(),
    );

    await mockNetworkImagesFor(() => tester.pumpWidget(gameCard));

    final findImage = find.byKey(const Key('game_image'));
    expect(findImage, findsOneWidget, reason: 'The game\'s image should be visible');
  });

  testWidgets('Verify the game\'s title is showing', (tester) async {
    const gameCard = MaterialApp(
      home: GameCard(),
    );

    await mockNetworkImagesFor(() => tester.pumpWidget(gameCard));

    final findImage = find.byKey(const Key('game_title'));
    expect(findImage, findsOneWidget, reason: 'The game\'s title should be visible');
  });

  testWidgets('Verify the play button is showing', (tester) async {
    const gameCard = MaterialApp(
      home: GameCard(),
    );

    await mockNetworkImagesFor(() => tester.pumpWidget(gameCard));

    final findImage = find.byKey(const Key('play_button'));
    expect(findImage, findsOneWidget, reason: 'The play button should be visible');
  });
}
