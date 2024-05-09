import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:talacare/domain/usecases/auth_usecase.dart';
import 'package:talacare/presentation/pages/login_page.dart';
import 'package:talacare/presentation/providers/auth_provider.dart';
import 'login_page_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthProvider>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<GetIt>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<AuthUseCase>(onMissingStub: OnMissingStub.returnDefault)
])
void main() {
  final getIt = GetIt.instance;
  late MockAuthProvider mockAuthProvider;

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    mockAuthProvider = MockAuthProvider();
    getIt.registerLazySingleton(() => AuthProvider(useCase: MockAuthUseCase()));
  });

  tearDown(() {
    getIt.unregister<AuthProvider>();
  });

  Widget buildLoginPage(AuthProvider authProvider) {
    return MaterialApp(
      home: ChangeNotifierProvider<AuthProvider>(
        create: (_) => authProvider,
        child: const LoginPage(),
      ),
    );
  }

  testWidgets('Verify the login preview image is showing', (tester) async {
    await tester.pumpWidget(buildLoginPage(mockAuthProvider));

    final loginPreviewImageFinder = find.byKey(const Key('login_preview'));
    expect(loginPreviewImageFinder, findsOneWidget,
        reason: 'The login preview image should be visible');
  });

  testWidgets('Verify the login button is showing', (tester) async {
    await tester.pumpWidget(buildLoginPage(mockAuthProvider));

    final loginButtonFinder = find.byKey(const Key('login_button'));
    expect(loginButtonFinder, findsOneWidget,
        reason: 'The login button should be visible');
  });

  testWidgets('Verify the snack bar is not shown when no error',
      (tester) async {
    await tester.pumpWidget(buildLoginPage(mockAuthProvider));

    await tester.pump();

    final snackBarFinder = find.byKey(const Key('snack_bar'));
    expect(snackBarFinder, findsNothing,
        reason: 'The snack bar should not be shown when no error');
  });

  testWidgets('Verify tapping on the login button', (tester) async {
    await tester.pumpWidget(buildLoginPage(getIt<AuthProvider>()));
    final loginButtonFinder = find.byKey(const Key('login_button'));
    await tester.tap(loginButtonFinder);
    await tester.pumpAndSettle(const Duration(seconds: 1));
    verify(getIt<AuthProvider>().signInWithGoogle()).called(1);
  });
}
