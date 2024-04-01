import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/presentation/widgets/add_schedule_time.dart';

void main() {
  group('Add Schedule Time Widget Tests', () {
    late Widget addScheduleTimeWidget;

    setUp(() {
      addScheduleTimeWidget = const MaterialApp(
        home: Scaffold(
          body: AddScheduleTime(),
        ),
      );
    });

    testWidgets('CupertinoDatePicker interaction updates selectedDate',
        (WidgetTester tester) async {
      await tester.pumpWidget(addScheduleTimeWidget);
      final cupertinoDatePickerFinder = find.byType(CupertinoDatePicker);
      expect(cupertinoDatePickerFinder, findsOneWidget);

      await tester.drag(cupertinoDatePickerFinder, const Offset(0, 32));
      await tester.pump();
      expect(cupertinoDatePickerFinder, findsOneWidget);
    });

    testWidgets('Add Schedule button closes modal',
        (WidgetTester tester) async {
      await tester.pumpWidget(addScheduleTimeWidget);
      final kembaliButtonFinder = find.text('Tambah');
      await tester.tap(kembaliButtonFinder);
      await tester.pumpAndSettle();
      expect(find.byType(AddScheduleTime), findsNothing);
    });

    testWidgets('Back button closes modal', (WidgetTester tester) async {
      await tester.pumpWidget(addScheduleTimeWidget);
      final kembaliButtonFinder = find.text('Kembali');
      await tester.tap(kembaliButtonFinder);
      await tester.pumpAndSettle();
      expect(find.byType(AddScheduleTime), findsNothing);
    });
  });
}
