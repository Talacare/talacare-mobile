import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/core/enums/button_color_scheme_enum.dart';
import 'package:talacare/presentation/widgets/button.dart';

void main() {
  final Widget button = MaterialApp(
    home: Scaffold(
      body: Center(
        child: Button(
          key: const Key('button'),
          text: 'Main',
          onTap: () {},
        ),
      ),
    ),
  );

  testWidgets('Verify the button is showing', (WidgetTester tester) async {
    await tester.pumpWidget(button);

    final findButton = find.byKey(const Key('button'));
    expect(findButton, findsOneWidget, reason: 'The button should be visible');
  });

  testWidgets('Verify the button\'s color scheme when provided',
      (WidgetTester tester) async {
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
    expect(findButton, findsOneWidget, reason: 'The button should be visible');

    final Button button = tester.widget(findButton);
    expect(button.colorScheme, ButtonColorScheme.purple,
        reason: 'The button should be used the green color scheme');
  });

  testWidgets('Verify the button\'s color scheme when not provided',
      (WidgetTester tester) async {
    await tester.pumpWidget(button);

    final findButton = find.byKey(const Key('button'));
    expect(findButton, findsOneWidget, reason: 'The button should be visible');

    final Button buttonWidget = tester.widget(findButton);
    expect(buttonWidget.colorScheme, ButtonColorScheme.green,
        reason: 'The button should be used the green color scheme');
  });

  testWidgets('Verify the button can be tapped', (WidgetTester tester) async {
    await tester.pumpWidget(button);

    final findButton = find.byKey(const Key('button'));
    expect(findButton, findsOneWidget, reason: 'The button should be visible');

    final Button buttonWidget = tester.widget(findButton);
    expect(buttonWidget.onTap, isNotNull,
        reason: 'The button should be able to be tapped');
  });

  testWidgets('Verify the button loading state', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: Button(
              key: Key('button'),
              text: 'Main',
              isLoading: true,
            ),
          ),
        ),
      ),
    );

    final findButton = find.byKey(const Key('button'));
    expect(findButton, findsOneWidget, reason: 'The button should be visible');

    final loadingIndicator = find.byType(CircularProgressIndicator);
    expect(loadingIndicator, findsOneWidget,
        reason:
            'The button should be showing circular progress indicator on loading');
  });
}
