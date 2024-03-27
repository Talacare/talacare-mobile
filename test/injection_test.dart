import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:talacare/data/datasources/auth_remote_datasource.dart';
import 'package:talacare/domain/repositories/auth_repository.dart';
import 'package:talacare/domain/usecases/auth_usecase.dart';
import 'package:talacare/presentation/providers/auth_provider.dart' as ap;
import 'package:talacare/injection.dart' as di;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setupFirebaseCoreMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  test('Verify all of the injections are registered', () async {
    await di.init();

    expect(di.getIt.isRegistered<ap.AuthProvider>(), isTrue);
    expect(di.getIt.isRegistered<AuthUseCase>(), isTrue);
    expect(di.getIt.isRegistered<AuthRepository>(), isTrue);
    expect(di.getIt.isRegistered<AuthRemoteDatasource>(), isTrue);
    expect(di.getIt.isRegistered<GoogleSignIn>(), isTrue);
    expect(di.getIt.isRegistered<FirebaseAuth>(), isTrue);
  });
}
