import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/core/constants/app_colors.dart';
import 'package:talacare/presentation/widgets/character_card.dart';

void main() {
  testWidgets('Verify the selected character card widget',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CharacterCard(
            onTap: () {},
            isSelected: true,
            imageName: 'boy_head.png',
          ),
        ),
      ),
    );

    final containerDecoration = tester
        .widget<Container>(find.byType(Container))
        .decoration as BoxDecoration;
    final boxShadow = containerDecoration.boxShadow![0];

    expect(find.byType(InkWell), findsOneWidget);
    expect(find.byType(Container), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(containerDecoration.color, AppColors.purple);
    expect(containerDecoration.border, isA<Border>());
    expect(containerDecoration.border!.top.color, Colors.white);
    expect(containerDecoration.border!.top.width, 2);
    expect(containerDecoration.borderRadius, BorderRadius.circular(15));
    expect(containerDecoration.boxShadow, isA<List<BoxShadow>>());
    expect(containerDecoration.boxShadow!.length, 1);
    expect(boxShadow.color, AppColors.yellow.withOpacity(0.8));
    expect(boxShadow.spreadRadius, 10);
    expect(boxShadow.blurRadius, 7);
  });

  testWidgets('Verify the unselected character card widget',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CharacterCard(
            onTap: () {},
            isSelected: false,
            imageName: 'boy_head.png',
          ),
        ),
      ),
    );

    final nonSelectedContainerDecoration = tester
        .widget<Container>(find.byType(Container))
        .decoration as BoxDecoration;
    final boxShadow = nonSelectedContainerDecoration.boxShadow![0];

    expect(find.byType(InkWell), findsOneWidget);
    expect(find.byType(Container), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(nonSelectedContainerDecoration.color, AppColors.purple);
    expect(nonSelectedContainerDecoration.border, isA<Border>());
    expect(nonSelectedContainerDecoration.border!.top.color, Colors.white);
    expect(nonSelectedContainerDecoration.border!.top.width, 2);
    expect(
        nonSelectedContainerDecoration.borderRadius, BorderRadius.circular(15));
    expect(nonSelectedContainerDecoration.boxShadow, isA<List<BoxShadow>>());
    expect(nonSelectedContainerDecoration.boxShadow!.length, 1);
    expect(boxShadow.color, Colors.transparent);
    expect(boxShadow.spreadRadius, 10);
    expect(boxShadow.blurRadius, 7);
  });

  testWidgets('Verify the character card widget with invalid image name',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CharacterCard(
            onTap: () {},
            isSelected: true,
            imageName: 'invalid.png',
          ),
        ),
      ),
    );

    expect(tester.takeException(), isNotNull);
  });
}
