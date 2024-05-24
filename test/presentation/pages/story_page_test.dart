import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/presentation/pages/story_page.dart';
import 'package:talacare/presentation/widgets/button.dart';

void main() {
  group('StoryPage', () {
    testWidgets('home button should be tappable', (WidgetTester tester) async {
      await tester
          .pumpWidget(const MaterialApp(home: StoryPage(storyType: 'test')));

      expect(find.byType(IconButton), findsOneWidget);
      await tester.tap(find.byType(IconButton));
      await tester.pump();
    });

    testWidgets('displays the correct number of gifs',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(const MaterialApp(home: StoryPage(storyType: 'test')));
      expect(find.byType(Image), findsAtLeast(1));
    });

    testWidgets('displays the correct gif', (WidgetTester tester) async {
      await tester
          .pumpWidget(const MaterialApp(home: StoryPage(storyType: 'test')));
      expect(
          find.byWidgetPredicate((widget) =>
              widget is Image &&
              widget.image ==
                  const AssetImage(
                      'assets/images/story/jump_n_jump/start/story0.gif')),
          findsOneWidget);
    });

    testWidgets('displays the correct gif count', (WidgetTester tester) async {
      await tester
          .pumpWidget(const MaterialApp(home: StoryPage(storyType: 'test')));
      expect(find.text('1/2'), findsOneWidget);
    });

    testWidgets('correctly updates gif count on button press',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(const MaterialApp(home: StoryPage(storyType: 'test')));

      await tester.tap(find.text('Lanjut'));
      await tester.pump();

      expect(find.text('2/2'), findsOneWidget);
    });

    testWidgets('displays the skip button when not on the last gif',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(const MaterialApp(home: StoryPage(storyType: 'test')));
      expect(find.text('Lewati'), findsOneWidget);
    });

    testWidgets('skip button has the correct width',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(const MaterialApp(home: StoryPage(storyType: 'test')));

      final buttonFinder = find.widgetWithText(Button, 'Lewati');
      expect(buttonFinder, findsOneWidget);

      final button = tester.widget<Button>(buttonFinder);
      expect(button.width, equals(120));
    });

    testWidgets('skip button disappears on last gif',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(const MaterialApp(home: StoryPage(storyType: 'test')));
      await tester.tap(find.text('Lanjut'));
      await tester.pump();
      expect(find.text('Lewati'), findsNothing);
    });

    testWidgets('last gif displays "Mainkan" for non-ending story type',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(const MaterialApp(home: StoryPage(storyType: 'test')));
      await tester.tap(find.text('Lanjut'));
      await tester.pump();
      expect(find.text('Mainkan'), findsOneWidget);
    });

    testWidgets('last gif displays "Selesai" for ending story type',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(const MaterialApp(home: StoryPage(storyType: 'Ending')));
      await tester.tap(find.text('Lanjut'));
      await tester.pump();
      expect(find.text('Selesai'), findsOneWidget);
    });
  });
}
