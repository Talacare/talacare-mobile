import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/presentation/widgets/delete_icon_button.dart';
import 'package:mockito/mockito.dart';

import 'add_schedule_modal_test.mocks.dart';

void main() {
  group('DeleteIconButton Tests', () {
    late MockScheduleProvider mockScheduleProvider;

    setUp(() {
      mockScheduleProvider = MockScheduleProvider();
    });

    testWidgets('shows loading indicator when delete operation is in progress',
        (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: DeleteIconButton(
              scheduleProvider: mockScheduleProvider,
              scheduleId: 'test-id',
              refreshSchedules: () {},
              showNotification: (String message, bool isSuccess) {},
            ),
          ),
        );

        when(mockScheduleProvider.deleteSchedule('test-id'))
            .thenAnswer((_) async {
          mockScheduleProvider.setError(false);
        });

        await tester.tap(find.byIcon(Icons.delete_outline));
        await tester.pump();

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
    });

    testWidgets('triggers delete operation successfully',
        (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: DeleteIconButton(
              scheduleProvider: mockScheduleProvider,
              scheduleId: 'test-id',
              refreshSchedules: () {},
              showNotification: (String message, bool isSuccess) {},
            ),
          ),
        );

        when(mockScheduleProvider.deleteSchedule('test-id'))
            .thenAnswer((_) async {
          mockScheduleProvider.setError(false);
          mockScheduleProvider.setMessage('Deleted successfully');
        });

        await tester.tap(find.byIcon(Icons.delete_outline));
        await tester.pump();

        verify(mockScheduleProvider.deleteSchedule('test-id')).called(1);
      });
    });

    testWidgets('triggers delete operation with error',
        (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: DeleteIconButton(
              scheduleProvider: mockScheduleProvider,
              scheduleId: 'test-id',
              refreshSchedules: () {},
              showNotification: (String message, bool isSuccess) {},
            ),
          ),
        );

        when(mockScheduleProvider.deleteSchedule('test-id'))
            .thenAnswer((_) async {
          mockScheduleProvider.setError(true);
          mockScheduleProvider.setMessage('An error message');
        });

        await tester.tap(find.byIcon(Icons.delete_outline));
        await tester.pump();

        verify(mockScheduleProvider.deleteSchedule('test-id')).called(1);
      });
    });

    testWidgets('handles error case during delete operation', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: DeleteIconButton(
              scheduleProvider: mockScheduleProvider,
              scheduleId: 'test-id',
              refreshSchedules: () {},
              showNotification: (String message, bool isSuccess) {},
            ),
          ),
        );

        when(mockScheduleProvider.deleteSchedule('test-id'))
            .thenAnswer((_) async {
          mockScheduleProvider.setError(true);
          mockScheduleProvider.setMessage('Deletion failed');
        });

        when(mockScheduleProvider.isError).thenReturn(true);

        await tester.tap(find.byIcon(Icons.delete_outline));
        await tester.pump();

        verify(mockScheduleProvider.deleteSchedule('test-id')).called(1);
      });
    });
  });
}
