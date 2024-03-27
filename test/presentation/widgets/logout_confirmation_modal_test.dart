import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/presentation/widgets/logout_confirmation_modal.dart';
import 'package:talacare/presentation/pages/home_page.dart';

void main() {
  late Widget logoutConfirmationModalWidget;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  setUp(() {
    logoutConfirmationModalWidget = const MaterialApp(
      home: Scaffold(
        body: LogoutConfirmationModal(),
      ),
    );
  });

  group('LogoutConfirmationModal Widget Tests', () {
    testWidgets('Yes button navigates to home page',
        (WidgetTester tester) async {
      await tester.pumpWidget(logoutConfirmationModalWidget);
      final yesButtonFinder = find.text('Iya');
      await tester.tap(yesButtonFinder);
      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets('No button closes modal', (WidgetTester tester) async {
      await tester.pumpWidget(logoutConfirmationModalWidget);
      final noButtonFinder = find.text('Tidak');
      await tester.tap(noButtonFinder);
      await tester.pumpAndSettle();
      expect(find.byType(LogoutConfirmationModal), findsNothing);
    });
  });
}
