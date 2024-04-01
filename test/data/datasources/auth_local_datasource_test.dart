import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:talacare/data/datasources/auth_local_datasource.dart';

import 'auth_local_datasource_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FlutterSecureStorage>(onMissingStub: OnMissingStub.returnDefault),
])
void main() {
  late MockFlutterSecureStorage storage;

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    storage = MockFlutterSecureStorage();
  });

  test('should return null if the data is not stored', () async {
    final dataSource = AuthLocalDatasourceImpl(
      storage: storage,
    );

    final result = await dataSource.readData('a_key');

    expect(result, isNull);
  });

  test('should return the value if the data is stored', () async {
    final dataSource = AuthLocalDatasourceImpl(
      storage: storage,
    );
    when(storage.read(key: 'a_key')).thenAnswer((_) => Future.value('Data'));
    final result = await dataSource.readData('a_key');

    expect(result, isNotNull);
    expect(result, equals('Data'));
  });


  test('should store the value', () async {
    final dataSource = AuthLocalDatasourceImpl(
      storage: storage,
    );

    await dataSource.storeData('a_key', 'Data');

    verify(storage.write(key: 'a_key', value: 'Data')).called(1);
  });
}
