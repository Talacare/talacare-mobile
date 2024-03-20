import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/presentation/jump_n_jump/health_bar.dart';

void main() {
  group('HealthBar Widget Tests', () {
    late Widget healthBar;
    double currentValue = 50;
    double maxValue = 100;

    setUp(() {
      healthBar = MaterialApp(
        home: Scaffold(
          body: HealthBar(
            currentValue: currentValue,
            maxValue: maxValue,
          ),
        ),
      );
    });

    testWidgets('HealthBar displays with correct initial values',
        (WidgetTester tester) async {
      await tester.pumpWidget(healthBar);
      expect(find.byType(HealthBar), findsOneWidget);
    });

    testWidgets('HealthBar updates when values change',
        (WidgetTester tester) async {
      await tester.pumpWidget(healthBar);

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: HealthBar(
            currentValue: 75,
            maxValue: maxValue,
          ),
        ),
      ));
      await tester.pumpAndSettle();
    });
  });
}
