import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/presentation/widgets/profile_modal.dart';
import 'package:talacare/presentation/widgets/logout_confirmation_modal.dart';

void main() {
  late Widget profileModalWidget;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  setUp(() {
    profileModalWidget = const MaterialApp(
      home: Scaffold(
        body: ProfileModal(),
      ),
    );
  });

  group('ProfileModal Widget Tests', () {
    testWidgets('Logout button triggers confirmation modal',
        (WidgetTester tester) async {
      await tester.pumpWidget(profileModalWidget);
      final logoutButtonFinder = find.text('Logout');
      await tester.tap(logoutButtonFinder);
      await tester.pumpAndSettle();
      expect(find.byType(LogoutConfirmationModal), findsOneWidget);
    });

    testWidgets('Back button closes modal', (WidgetTester tester) async {
      await tester.pumpWidget(profileModalWidget);
      final kembaliButtonFinder = find.text('Kembali');
      await tester.tap(kembaliButtonFinder);
      await tester.pumpAndSettle();
      expect(find.byType(ProfileModal), findsNothing);
    });
  });
}
