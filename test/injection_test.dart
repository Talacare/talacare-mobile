import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:talacare/data/datasources/auth_remote_datasource.dart';
import 'package:talacare/data/datasources/schedule_remote_datasource.dart';
import 'package:talacare/data/datasources/game_history_remote_datasource.dart';
import 'package:talacare/domain/repositories/auth_repository.dart';
import 'package:talacare/domain/repositories/schedule_repository.dart';
import 'package:talacare/domain/repositories/game_history_repository.dart';
import 'package:talacare/domain/usecases/auth_usecase.dart';
import 'package:talacare/domain/usecases/schedule_usecase.dart';
import 'package:talacare/domain/usecases/game_history_usecase.dart';
import 'package:talacare/presentation/providers/auth_provider.dart' as ap;
import 'package:talacare/injection.dart' as di;
import 'package:talacare/presentation/providers/schedule_provider.dart' as sp;
import 'package:talacare/presentation/providers/game_history_provider.dart'
    as ghp;

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
    expect(di.getIt.isRegistered<Dio>(), isTrue);
    expect(di.getIt.isRegistered<FlutterSecureStorage>(), isTrue);
    expect(di.getIt.isRegistered<sp.ScheduleProvider>(), isTrue);
    expect(di.getIt.isRegistered<ScheduleUseCase>(), isTrue);
    expect(di.getIt.isRegistered<ScheduleRepository>(), isTrue);
    expect(di.getIt.isRegistered<ScheduleRemoteDatasource>(), isTrue);
    expect(di.getIt.isRegistered<GameHistoryUseCase>(), isTrue);
    expect(di.getIt.isRegistered<GameHistoryRepository>(), isTrue);
    expect(di.getIt.isRegistered<GameHistoryRemoteDatasource>(), isTrue);
    expect(di.getIt.isRegistered<ghp.GameHistoryProvider>(), isTrue);
  });
}
