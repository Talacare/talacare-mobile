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
  late AuthLocalDatasourceImpl dataSource;

  setUp(() {
    storage = MockFlutterSecureStorage();
    dataSource = AuthLocalDatasourceImpl(storage: storage);
  });

  test('should return null if the data is not stored', () async {
    final result = await dataSource.readData('a_key');
    expect(result, isNull);
  });

  test('should return the value if the data is stored', () async {
    when(storage.read(key: 'a_key')).thenAnswer((_) => Future.value('Data'));
    final result = await dataSource.readData('a_key');
    expect(result, isNotNull);
    expect(result, equals('Data'));
  });

  test('should store the value', () async {
    await dataSource.storeData('a_key', 'Data');
    verify(storage.write(key: 'a_key', value: 'Data')).called(1);
  });

  test('should delete the data for a given key and verify the data is removed',
      () async {
    when(storage.read(key: 'a_key')).thenAnswer((_) async => 'Data');
    when(storage.delete(key: 'a_key')).thenAnswer((_) async {
      when(storage.read(key: 'a_key')).thenAnswer((_) async => null);
      return;
    });
    await dataSource.deleteData('a_key');
    verify(storage.delete(key: 'a_key')).called(1);
    final result = await dataSource.readData('a_key');
    expect(result, isNull);
  });

  test('attempt to delete non-existing data', () async {
    when(storage.delete(key: 'non_existing_key')).thenAnswer((_) async {});
    await dataSource.deleteData('non_existing_key');
    verify(storage.delete(key: 'non_existing_key')).called(1);
  });
}
