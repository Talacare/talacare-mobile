import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/presentation/jump_n_jump/health_bar.dart';

void main() {
  group('HealthBar Widget Tests', () {
    late ValueNotifier<double> currentValueNotifier;
    double maxValue = 100;

    setUp(() {
      currentValueNotifier = ValueNotifier<double>(50);
    });

    testWidgets('HealthBar displays with correct initial values',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: HealthBar(
            currentValue: currentValueNotifier,
            maxValue: maxValue,
          ),
        ),
      ));

      await tester.pumpAndSettle();
      expect(find.byType(HealthBar), findsOneWidget);
    });

    testWidgets('HealthBar updates when currentValue changes',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: HealthBar(
            currentValue: currentValueNotifier,
            maxValue: maxValue,
          ),
        ),
      ));

      currentValueNotifier.value = 75;
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
    });
  });
}
