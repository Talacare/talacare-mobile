import 'package:talacare/data/datasources/export_data_remote_datasource.dart';
import 'package:talacare/domain/repositories/export_data_repository.dart';

class ExportDataRepositoryImpl extends ExportDataRepository {
  final ExportDataRemoteDatasource exportDataRemoteDatasource;

  ExportDataRepositoryImpl(this.exportDataRemoteDatasource);

  @override
  Future<void> exportGameData() async {
    await exportDataRemoteDatasource.exportData();
  }
}
