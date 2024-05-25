import 'package:talacare/domain/repositories/export_data_repository.dart';

class ExportDataUseCase {
  final ExportDataRepository exportDataRepository;

  ExportDataUseCase(this.exportDataRepository);

  Future<void> exportGameData() async {
    await exportDataRepository.exportGameData();
  }
}
