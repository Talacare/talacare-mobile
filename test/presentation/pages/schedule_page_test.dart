import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/presentation/pages/schedule_page.dart';
import 'package:talacare/presentation/widgets/button.dart';

void main() {
  group('SchedulePage widget test', () {
    testWidgets('Test header text', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SchedulePage()));

      final headerText1 = find.text('JADWAL KONSUMSI');
      final headerText2 = find.text('OBAT KELASI BESI');

      expect(headerText1, findsOneWidget);
      expect(headerText2, findsOneWidget);
    });

    testWidgets('Test add schedule button text', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SchedulePage()));

      final addScheduleButton = find.widgetWithText(Button, 'Tambah Jadwal');
      expect(addScheduleButton, findsOneWidget);

      await tester.tap(addScheduleButton);
      await tester.pump();
    });

    testWidgets('Test back button text', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SchedulePage()));

      final backButton = find.widgetWithText(Button, 'Menu');
      expect(backButton, findsOneWidget);

      await tester.tap(backButton);
      await tester.pump();
    });

    testWidgets('Test delete button onPressed', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SchedulePage()));

      final deleteButtons = find.byType(IconButton);

      for (var i = 0; i < deleteButtons.evaluate().length; i++) {
        await tester.ensureVisible(deleteButtons.at(i));
        await tester.tap(deleteButtons.at(i));
        await tester.pump();
      }
    });
  });
}
