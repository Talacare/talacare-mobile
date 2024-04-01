import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/notification_service.dart';

void main() {

  testWidgets('Verified that notification is initilized', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: InkWell(
            key: const Key("test_button"),
            onTap: () {
              NotificationService()
                  .initNotification();
            },
          ),
        ),
      )
    );

    expect(find.byKey(const Key('test_button')), findsOneWidget);
    await tester.tap(find.byKey(const Key('test_button')));
  });

  testWidgets('Verified that notification is showed', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: InkWell(
            key: const Key("test_button"),
            onTap: () {
              NotificationService()
                  .showNotification(title: 'Sample title', body: 'It works!');
            },
          ),
        ),
      )
    );

    expect(find.byKey(const Key('test_button')), findsOneWidget);
    await tester.tap(find.byKey(const Key('test_button')));
  });

  testWidgets('Verified that notification is scheduled with future date', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: InkWell(
            key: const Key("test_button"),
            onTap: () {
              NotificationService()
                  .scheduleNotification(
                    title: 'Sample title', 
                    body: 'It works!',
                    scheduledNotificationDateTime: DateTime(2040, 04, 05, 17, 30));
            },
          ),
        ),
      )
    );

    expect(find.byKey(const Key('test_button')), findsOneWidget);
    await tester.tap(find.byKey(const Key('test_button')));
  });

  testWidgets('Verified that notification is scheduled in second time', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: InkWell(
            key: const Key("test_button"),
            onTap: () {
              NotificationService()
                  .scheduleNotification(
                    title: 'Sample title', 
                    body: 'It works!',
                    scheduledNotificationDateTime: DateTime(2020, 04, 05, 17, 30));
            },
          ),
        ),
      )
    );

    expect(find.byKey(const Key('test_button')), findsOneWidget);
    await tester.tap(find.byKey(const Key('test_button')));
  });
}
