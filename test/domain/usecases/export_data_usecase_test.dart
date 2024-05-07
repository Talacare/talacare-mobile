import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:talacare/domain/repositories/export_data_repository.dart';
import 'package:talacare/domain/usecases/export_data_usecase.dart';

import 'export_data_usecase_test.mocks.dart';

@GenerateMocks([ExportDataRepository])
void main() {
  late ExportDataUseCase useCase;
  late MockExportDataRepository mockExportDataRepository;

  setUp(() {
    mockExportDataRepository = MockExportDataRepository();
    useCase = ExportDataUseCase(mockExportDataRepository);
  });

  test('should invoke createSchedule on the schedule repository', () async {
    when(mockExportDataRepository.exportGameData()).thenAnswer((_) async => {});
    await useCase.exportGameData();
    verify(mockExportDataRepository.exportGameData()).called(1);
  });
}
