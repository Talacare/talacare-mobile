import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/presentation/widgets/home_button.dart';

void main() {
  testWidgets('Home Button widget test', (WidgetTester tester) async {
    bool wasTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HomeButton(
            onTap: () {
              wasTapped = true;
            },
          ),
        ),
      ),
    );

    expect(find.byKey(const Key('home_button')), findsOneWidget);
    expect(find.byKey(const Key('shadow_layer')), findsOneWidget);
    expect(find.byKey(const Key('main_layer')), findsOneWidget);
    expect(find.byKey(const Key('home_icon')), findsOneWidget);

    await tester.tap(find.byKey(const Key('home_button')));
    await tester.pump();
    expect(wasTapped, isTrue);
  });
}
