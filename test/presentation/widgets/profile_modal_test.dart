import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:talacare/presentation/providers/auth_provider.dart';
import 'package:talacare/presentation/widgets/profile_modal.dart';
import 'package:talacare/presentation/widgets/logout_confirmation_modal.dart';

import '../providers/auth_provider_test.mocks.dart';

void main() {
  late Widget profileModal;
  final getIt = GetIt.instance;

  TestWidgetsFlutterBinding.ensureInitialized();
  setupFirebaseCoreMocks();

  setUp(() async {
    await Firebase.initializeApp();

    getIt.registerLazySingleton(() => AuthProvider(useCase: MockAuthUseCase()));

    profileModal = const MaterialApp(
      home: Scaffold(
        body: ProfileModal(),
      ),
    );
  });

  tearDown(() {
    getIt.unregister<AuthProvider>();
  });

  group('ProfileModal Widget Tests', () {
    testWidgets('Username is displayed', (WidgetTester tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(profileModal));
      final userName = find.byKey(const Key('user_name'));
      expect(userName, findsOneWidget);
    });

    testWidgets('Email is displayed', (WidgetTester tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(profileModal));
      final userEmail = find.byKey(const Key('user_email'));
      expect(userEmail, findsOneWidget);
    });

    testWidgets('Profile picture is displayed', (WidgetTester tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(profileModal));
      final userPicture = find.byKey(const Key('user_picture'));
      expect(userPicture, findsOneWidget);
    });

    testWidgets('Logout button triggers confirmation modal',
        (WidgetTester tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(profileModal));
      final logoutButtonFinder = find.text('Keluar');
      await tester.tap(logoutButtonFinder);
      await tester.pumpAndSettle();
      expect(find.byType(LogoutConfirmationModal), findsOneWidget);
    });

    testWidgets('Back button closes modal', (WidgetTester tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(profileModal));
      final kembaliButtonFinder = find.text('Kembali');
      await tester.tap(kembaliButtonFinder);
      await tester.pumpAndSettle();
      expect(find.byType(ProfileModal), findsNothing);
    });
  });
}
