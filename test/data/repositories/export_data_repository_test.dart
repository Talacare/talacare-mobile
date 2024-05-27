import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:talacare/data/datasources/export_data_remote_datasource.dart';
import 'package:talacare/data/repositories/export_data_repository_impl.dart';
import 'export_data_repository_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<ExportDataRemoteDatasource>(
      onMissingStub: OnMissingStub.returnDefault)
])
void main() {
  late ExportDataRepositoryImpl repository;
  late MockExportDataRemoteDatasource mockRemoteDatasource;

  setUp(() {
    mockRemoteDatasource = MockExportDataRemoteDatasource();
    repository = ExportDataRepositoryImpl(mockRemoteDatasource);
  });

  test('should call export game data of export data remote datasource',
      () async {
    when(mockRemoteDatasource.exportData())
        .thenAnswer((_) async => Future.value());
    await repository.exportGameData();
    verify(mockRemoteDatasource.exportData()).called(1);
  });
}
