import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/presentation/pages/modal_page.dart';

void main() {
  group('Modal Widget Tests', () {
    testWidgets('Modal displays correct text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: tester.element(find.byType(ElevatedButton)),
                    builder: (BuildContext context) {
                      return const Modal();
                    },
                  );
                },
                child: const Text('Show Modal'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Modal'));
      await tester.pumpAndSettle();

      final findLogo = find.byKey(const Key('mainlagi'));
      expect(findLogo, findsOneWidget,
          reason: 'Main lagi asset should be visible');
    });
  });
}
