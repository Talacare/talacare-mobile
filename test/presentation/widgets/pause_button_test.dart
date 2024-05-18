import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/presentation/widgets/pause_button.dart';

void main() {
  testWidgets('Pause Button widget test', (WidgetTester tester) async {
    bool wasTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PauseButton(
            onTap: () {
              wasTapped = true;
            },
          ),
        ),
      ),
    );

    expect(find.byKey(const Key('pause_button')), findsOneWidget);
    expect(find.byKey(const Key('shadow_layer')), findsOneWidget);
    expect(find.byKey(const Key('main_layer')), findsOneWidget);
    expect(find.byKey(const Key('pause_icon')), findsOneWidget);

    await tester.tap(find.byKey(const Key('pause_button')));
    await tester.pump();
    expect(wasTapped, isTrue);
  });
}
