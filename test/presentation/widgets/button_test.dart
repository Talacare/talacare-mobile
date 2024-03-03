import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/presentation/widgets/button.dart';

void main() {
  group('Unit Tests of Button Widget', () {
    
    testWidgets('Verify the button is showing', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: Button(
                key: Key('button'),
                text: 'Main',
              ),
            ),
          ),
        ),
      );

      final findButton = find.byKey(const Key('button'));
      expect(findButton, findsOneWidget,
          reason: 'The button should be visible');
    });

    testWidgets('Verify the button\'s color scheme when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: Button(
                key: Key('button'),
                text: 'Main',
                colorScheme: ButtonColorScheme.purple,
              ),
            ),
          ),
        ),
      );

      final findButton = find.byKey(const Key('button'));
      expect(findButton, findsOneWidget,
          reason: 'The button should be visible');

      final Button button = tester.widget(findButton);
      expect(button.colorScheme, ButtonColorScheme.purple,
          reason: 'The button should be used the green color scheme');
    });

    testWidgets('Verify the button\'s color scheme when not provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: Button(
                key: Key('button'),
                text: 'Main',
              ),
            ),
          ),
        ),
      );

      final findButton = find.byKey(const Key('button'));
      expect(findButton, findsOneWidget,
          reason: 'The button should be visible');

      final Button button = tester.widget(findButton);
      expect(button.colorScheme, ButtonColorScheme.green,
          reason: 'The button should be used the green color scheme');
    });

    testWidgets('Verify the button can be tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: Button(
                key: Key('button'),
                text: 'Main',
                onTap: (){},
              ),
            ),
          ),
        ),
      );

      final findButton = find.byKey(const Key('button'));
      expect(findButton, findsOneWidget,
          reason: 'The button should be visible');

      final Button button = tester.widget(findButton);
      expect(button.onTap, isNotNull,
          reason: 'The button should be able to be tapped');
    });
  });
}