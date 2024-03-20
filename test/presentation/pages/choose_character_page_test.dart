import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:talacare/core/constants/app_colors.dart';
import 'package:talacare/presentation/pages/choose_character_page.dart';
import 'package:talacare/presentation/pages/jump_n_jump_page.dart';
import 'package:talacare/presentation/widgets/character_card.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  BoxShadow getCharacterCardBoxShadow(
      FinderBase<Element> finder, WidgetTester tester) {
    final inkWell = tester.widget<InkWell>(finder);
    final container = inkWell.child as Container;
    return (container.decoration as BoxDecoration).boxShadow![0];
  }

  testWidgets(
      '[Positive] Verify that all the character cards, title, and button are visible',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ChooseCharacterPage(),
      ),
    );

    expect(find.text('Pilih Karaktermu!'), findsOneWidget);
    expect(find.byType(CharacterCard), findsNWidgets(2));
    expect(find.text('Mulai'), findsOneWidget);
  });

  testWidgets(
      '[Positive] Verify that the game starts after clicking one character options',
      (WidgetTester tester) async {
    final mockObserver = MockNavigatorObserver();

    await tester.pumpWidget(
      MaterialApp(
        home: const ChooseCharacterPage(),
        navigatorObservers: [mockObserver],
      ),
    );

    await tester.tap(find.byType(CharacterCard).first);
    await tester.pumpAndSettle();

    final boyBoxShadow = getCharacterCardBoxShadow(
        find.byKey(const Key('character_card')).first, tester);
    expect(boyBoxShadow.color, AppColors.yellow.withOpacity(0.8));

    await tester.tap(find.text('Mulai'));
    await tester.pumpAndSettle();
    expect(find.byType(JumpNJumpPage), findsOneWidget);
  });

  testWidgets(
      '[Negative] Verify that the game starts without selecting any character options',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ChooseCharacterPage(),
      ),
    );

    await tester.tap(find.text('Mulai'));
    await tester.pump();
    expect(find.byType(JumpNJumpPage), findsNothing);
  });

  testWidgets(
      '[Edge] Verify clicking on character options multiple times, alternating between selections.',
      (WidgetTester tester) async {
    final mockObserver = MockNavigatorObserver();

    await tester.pumpWidget(
      MaterialApp(
        home: const ChooseCharacterPage(),
        navigatorObservers: [mockObserver],
      ),
    );

    await tester.tap(find.byType(CharacterCard).first);
    await tester.pumpAndSettle();
    await tester.tap(find.byType(CharacterCard).last);
    await tester.pumpAndSettle();

    final boyBoxShadow = getCharacterCardBoxShadow(
        find.byKey(const Key('character_card')).first, tester);
    final girlBoxShadow = getCharacterCardBoxShadow(
        find.byKey(const Key('character_card')).last, tester);
    expect(boyBoxShadow.color, Colors.transparent);
    expect(girlBoxShadow.color, AppColors.yellow.withOpacity(0.8));

    await tester.tap(find.text('Mulai'));
    await tester.pumpAndSettle();
    expect(find.byType(JumpNJumpPage), findsOneWidget);
  });
}
