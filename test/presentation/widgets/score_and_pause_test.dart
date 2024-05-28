import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/core/constants/app_colors.dart';
import 'package:talacare/presentation/widgets/pause_button.dart';
import 'package:talacare/presentation/widgets/score_and_pause.dart';

void main() {
  group('ScoreAndPause Widget Tests', () {
    testWidgets('displays the correct high score', (WidgetTester tester) async {
      const highScore = 999;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ScoreAndPause(
              highScore: highScore,
              onPauseTap: (){},
            ),
          ),
        ),
      );

      expect(find.text('$highScore'), findsOneWidget);
    });

    testWidgets('triggers onPauseTap when pause button is tapped', (WidgetTester tester) async {
      bool wasTapped = false;
      void onTap() => wasTapped = true;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ScoreAndPause(
              highScore: 999,
              onPauseTap: onTap,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(PauseButton));
      await tester.pumpAndSettle();

      expect(wasTapped, isTrue);
    });

    testWidgets('displays the trophy icon correctly', (WidgetTester tester) async {
      const trophyIcon = '🏆';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ScoreAndPause(
              highScore: 999,
              onPauseTap: (){},
            ),
          ),
        ),
      );

      expect(find.text(trophyIcon), findsOneWidget);
      final trophyContainer = tester.widget<Container>(find.byType(Container).first);
      expect(trophyContainer.decoration, isInstanceOf<BoxDecoration>());
      final decoration = trophyContainer.decoration as BoxDecoration;
      expect(decoration.color, AppColors.orange);
      expect(decoration.shape, BoxShape.circle);
    });

    testWidgets('layout is correct with given elements', (WidgetTester tester) async {
      const highScore = 999;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ScoreAndPause(
              highScore: highScore,
              onPauseTap: (){},
            ),
          ),
        ),
      );

      final row = find.byType(Row);
      expect(row, findsNWidgets(1));
      final text = find.text('$highScore');
      expect(text, findsOneWidget);
      expect(tester.widget<Text>(text).style!.color, AppColors.violet);
      expect(tester.widget<Text>(text).style!.fontSize, 35);
    });
  });
}
