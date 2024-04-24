import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:provider/provider.dart';
import 'package:talacare/domain/usecases/schedule_usecase.dart';
import 'package:talacare/presentation/providers/schedule_provider.dart';
import 'package:talacare/presentation/widgets/add_schedule_modal.dart';
import 'add_schedule_modal_test.mocks.dart';

void mockOnScheduleAdded() {}

@GenerateNiceMocks([
  MockSpec<ScheduleProvider>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<GetIt>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<ScheduleUseCase>(onMissingStub: OnMissingStub.returnDefault)
])
void main() {
  group('Add Schedule Modal Widget Tests', () {
    late MockScheduleProvider mockScheduleProvider;

    setUpAll(() {
      final getIt = GetIt.instance;
      mockScheduleProvider = MockScheduleProvider();
      getIt.registerLazySingleton(
          () => ScheduleProvider(useCase: MockScheduleUseCase()));
    });

    Widget buildAddScheduleModalPage(ScheduleProvider scheduleProvider) {
      return ChangeNotifierProvider<ScheduleProvider>(
        create: (_) => scheduleProvider,
        child: const MaterialApp(
          home: AddScheduleModal(onScheduleAdded: mockOnScheduleAdded),
        ),
      );
    }

    testWidgets('CupertinoDatePicker interaction updates selectedDate',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildAddScheduleModalPage(mockScheduleProvider));
      final cupertinoDatePickerFinder = find.byType(CupertinoDatePicker);
      expect(cupertinoDatePickerFinder, findsOneWidget);

      await tester.drag(cupertinoDatePickerFinder, const Offset(0, 32));
      await tester.pump();
      expect(cupertinoDatePickerFinder, findsOneWidget);
    });

    testWidgets('Add Schedule button closes modal',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildAddScheduleModalPage(mockScheduleProvider));
      final tambahButtonFinder = find.text('Tambah');
      await tester.tap(tambahButtonFinder);
      await tester.pumpAndSettle(const Duration(seconds: 2));
    });

    testWidgets('Back button closes modal', (WidgetTester tester) async {
      await tester.pumpWidget(buildAddScheduleModalPage(mockScheduleProvider));
      final kembaliButtonFinder = find.text('Kembali');
      await tester.ensureVisible(kembaliButtonFinder);
      await tester.tap(kembaliButtonFinder);
      await tester.pumpAndSettle();
      expect(find.byType(AddScheduleModal), findsNothing);
    });
  });
}
