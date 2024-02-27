import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/presentation/puzzle/circle_timer.dart';
import 'package:talacare/core/constants/app_colors.dart';

void main() {
  testWidgets('CircleTimer widget has correct CircularProgressIndicator color',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: CircleTimer(),
      ),
    );
    CircularProgressIndicator circularProgressIndicator =
        tester.widget(find.byType(CircularProgressIndicator));
    expect(circularProgressIndicator.backgroundColor, AppColors.purple);

    expect(circularProgressIndicator.valueColor,
        isInstanceOf<AlwaysStoppedAnimation<Color>>());
  });
  testWidgets('CircleTimer widget always display 60 seconds at the beginning',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: CircleTimer(),
      ),
    );

    expect(find.text('60'), findsOneWidget);
    await tester.pumpWidget(
      const MaterialApp(
        home: CircleTimer(),
      ),
    );
    expect(find.text('60'), findsOneWidget);
  });
  testWidgets('CircleTimer widget display remaining seconds after time passed',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: CircleTimer(),
      ),
    );
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('59'), findsOneWidget);

    await tester.pump(const Duration(seconds: 59));
    expect(find.text('0'), findsOneWidget);
  });
  testWidgets(
      'CircleTimer widget continues to display 0 seconds even after more than 60 seconds have passed',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: CircleTimer(),
      ),
    );
    await tester.pump(const Duration(seconds: 70));
    expect(find.text('0'), findsOneWidget);
  });
}
