import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:talacare/presentation/providers/auth_provider.dart';
import 'package:talacare/presentation/widgets/logout_confirmation_modal.dart';
import '../providers/auth_provider_test.mocks.dart';

void main() {
  late Widget logoutConfirmationModal;
  final getIt = GetIt.instance;

  TestWidgetsFlutterBinding.ensureInitialized();
  setupFirebaseCoreMocks();

  setUp(() async {
    await Firebase.initializeApp();

    getIt.registerLazySingleton(() => AuthProvider(useCase: MockAuthUseCase()));

    logoutConfirmationModal = const MaterialApp(
      home: Scaffold(
        body: LogoutConfirmationModal(),
      ),
    );
  });

  tearDown(() {
    getIt.unregister<AuthProvider>();
  });

  group('Positive - LogoutConfirmationModal Widget Tests', () {
    testWidgets('Yes button calls logout', (WidgetTester tester) async {
      await tester.pumpWidget(logoutConfirmationModal);
      final yesButtonFinder = find.text('Iya');
      await tester.tap(yesButtonFinder);
      verify(getIt<AuthProvider>().logOut()).called(1);
    });

    testWidgets('Negative - No button closes modal',
        (WidgetTester tester) async {
      await tester.pumpWidget(logoutConfirmationModal);
      final noButtonFinder = find.text('Tidak');
      await tester.tap(noButtonFinder);
      await tester.pumpAndSettle();
      expect(find.byType(LogoutConfirmationModal), findsNothing);
      verifyNever(getIt<AuthProvider>().logOut());
    });
  });
}
