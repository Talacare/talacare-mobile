import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/core/constants/app_colors.dart';
import 'package:talacare/presentation/widgets/button.dart';

void main() {
  group('Button Widget Tests', () {
    
    testWidgets('Button is correct and clickable', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: Button(
                key: Key('nextButton'),
                text: 'Main',
                color: AppColors.darkGreen,
                firstShadowColor: AppColors.mediumGreen,
                secondShadowColor: AppColors.lightGreen,
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(const Key('nextButton')));
      await tester.pumpAndSettle();
    });
  });
}