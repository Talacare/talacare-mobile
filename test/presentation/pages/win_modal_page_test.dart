import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/presentation/pages/win_modal_page.dart';

void main() {
  group('Win Puzzle Modal Widget Tests', () {
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
                      return const WinModal();
                    },
                  );
                },
                child: const Text('Show Win Modal'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Win Modal'));
      await tester.pumpAndSettle();

      final findText = find.text('Lanjut');
      expect(findText, findsOneWidget,
          reason: 'Lanjut Button should be visible');
    });
  });
}
