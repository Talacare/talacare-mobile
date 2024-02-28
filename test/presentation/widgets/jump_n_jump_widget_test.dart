import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:talacare/presentation/jump_n_jump/jump_n_jump.dart';
import 'package:talacare/presentation/widgets/jump_n_jump_widget.dart';

class MockJumpNJump extends Mock implements JumpNJump {}

void main() {
  group('JumpNJumpWidget Tests', () {
    late JumpNJump game;
    late MockJumpNJump mockGame;

    setUp(() {
      mockGame = MockJumpNJump();
      game = JumpNJump();
    });

    testWidgets('Should display score and coin icon correctly',
        (WidgetTester tester) async {
      when(mockGame.gameManager.score).thenReturn(ValueNotifier<int>(0));

      await tester.pumpWidget(MaterialApp(
        home: JumpNJumpWidget(),
      ));

      expect(find.text('0'), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('Should have left and right control buttons',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: JumpNJumpWidget(),
      ));

      expect(find.byType(ElevatedButton), findsNWidgets(2));
    });

    testWidgets('Tapping left control button triggers moveLeft',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: JumpNJumpWidget(),
      ));

      final leftButton = find.byType(ElevatedButton).first;
      await tester.tap(leftButton);
      await tester.pump();

      verify(mockGame.dash.moveLeft()).called(1);
    });

    testWidgets('Tapping right control button triggers moveRight',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: JumpNJumpWidget(),
      ));

      final rightButton = find.byType(ElevatedButton).last;
      await tester.tap(rightButton);
      await tester.pump();

      verify(mockGame.dash.moveRight()).called(1);
    });
  });
}
