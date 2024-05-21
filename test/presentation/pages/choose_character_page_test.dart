import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:talacare/core/constants/app_colors.dart';
import 'package:talacare/presentation/pages/choose_character_page.dart';
import 'package:talacare/presentation/pages/jump_n_jump_page.dart';
import 'package:talacare/presentation/providers/game_history_provider.dart';
import 'package:talacare/presentation/widgets/character_card.dart';
import 'package:talacare/presentation/widgets/home_button.dart';

import '../jump_n_jump/jump_n_jump_test.mocks.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  final mockObserver = MockNavigatorObserver();
  final characterPage = MaterialApp(
    home: const ChooseCharacterPage(),
    navigatorObservers: [mockObserver],
  );

  BoxShadow getCharacterCardBoxShadow(
      FinderBase<Element> finder, WidgetTester tester) {
    final inkWell = tester.widget<InkWell>(finder);
    final container = inkWell.child as Container;
    return (container.decoration as BoxDecoration).boxShadow![0];
  }

  final getIt = GetIt.instance;
  late MockGameHistoryProvider mockGameHistoryProvider;

  setUp(() async {
    mockGameHistoryProvider = MockGameHistoryProvider();
    getIt.registerSingleton<GameHistoryProvider>(mockGameHistoryProvider);
  });

  tearDown(() {
    getIt.reset();
  });

  testWidgets(
      '[Positive] Verify that all the character cards, title, and button are visible',
      (WidgetTester tester) async {
    await tester.pumpWidget(characterPage);

    expect(find.text('Pilih Karaktermu!'), findsOneWidget);
    expect(find.byType(CharacterCard), findsNWidgets(2));
    expect(find.text('Mulai'), findsOneWidget);
  });

  testWidgets(
      '[Positive] Verify that the game starts after clicking one character options',
      (WidgetTester tester) async {
    await tester.pumpWidget(characterPage);

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
    await tester.pumpWidget(characterPage);

    await tester.tap(find.text('Mulai'));
    await tester.pump();
    expect(find.byType(JumpNJumpPage), findsNothing);
  });

  testWidgets(
      '[Edge] Verify clicking on character options multiple times, alternating between selections.',
      (WidgetTester tester) async {
    await tester.pumpWidget(characterPage);

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

  testWidgets('triggers onTap when home button is tapped',
      (WidgetTester tester) async {
    await tester.pumpWidget(characterPage);
    expect(find.byType(HomeButton), findsOneWidget);
    await tester.tap(find.byType(HomeButton));
    await tester.pumpAndSettle();
  });
}
