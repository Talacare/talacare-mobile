import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/presentation/widgets/custom_notification.dart';

void main() {
  testWidgets('CustomNotification show test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () {
                  CustomNotification.show(context,
                      message: 'Test message', isSuccess: true);
                },
                child: const Text('Show Notification'),
              ),
            ),
          );
        },
      ),
    ));

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    await tester.pumpAndSettle(const Duration(seconds: 2));
  });
}
