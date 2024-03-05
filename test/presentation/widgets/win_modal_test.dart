import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/presentation/widgets/next_info.dart';

void main() {
  group('Win Puzzle Modal Widget Tests', () {
    testWidgets('Verify All Components are showing', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: NextInfo(),
        ),
      ));

      expect(find.text('SUSTER'), findsOneWidget);
      expect(find.text('Lanjut'), findsOneWidget);
    });

    testWidgets('Button is clickable', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: NextInfo(),
        ),
      ));
      await tester.tap(find.byKey(const Key('nextButton')));
      await tester.pump();
    });
  });
}
