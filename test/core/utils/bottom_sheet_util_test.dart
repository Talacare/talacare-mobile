import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/core/utils/bottom_sheet_util.dart';

void main() {
  testWidgets('BottomSheetUtil showBottomSheet Test', (WidgetTester tester) async {
    bool isButtonTapped = false;

    await tester.pumpWidget(MaterialApp(
      home: Builder(
        builder: (BuildContext context) {
          return ElevatedButton(
            onPressed: () {
              BottomSheetUtil.showBottomSheet(
                context: context,
                title: 'Test Title',
                description: 'Test Description',
                textButton: 'Test Button',
                onTap: () {
                  isButtonTapped = true;
                },
              );
            },
            child: const Text('Show Bottom Sheet'),
          );
        },
      ),
    ));

    await tester.tap(find.text('Show Bottom Sheet'));
    await tester.pumpAndSettle();

    expect(find.text('Test Title'), findsOneWidget);
    expect(find.text('Test Description'), findsOneWidget);
    expect(find.text('Test Button'), findsOneWidget);

    await tester.tap(find.text('Test Button'));
    await tester.pumpAndSettle();

    expect(isButtonTapped, true);
  });
}
