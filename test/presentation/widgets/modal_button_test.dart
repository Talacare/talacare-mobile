import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/presentation/widgets/modal_button.dart';

void main() {
  group('ModalButton Widget Tests', () {
    testWidgets('Widget taps properly', (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: Center(
              child: ModalButton(
                text: 'Test Button',
                color: Colors.blue,
                borderColor: Colors.white,
                textColor: Colors.black,
                onTap: () {
                  tapped = true;
                },
              ),
            ),
          ),
        ),
      );

      final modalButtonFinder = find.byType(ModalButton);
      await tester.tap(modalButtonFinder);
      await tester.pumpAndSettle();
      expect(tapped, true);
    });
  });
}
