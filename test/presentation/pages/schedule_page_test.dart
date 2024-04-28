import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:talacare/domain/usecases/schedule_usecase.dart';
import 'package:talacare/presentation/pages/schedule_page.dart';
import 'package:talacare/presentation/providers/schedule_provider.dart';
import 'package:talacare/presentation/widgets/add_schedule_modal.dart';
import 'package:talacare/presentation/widgets/button.dart';
import 'package:talacare/notification_service.dart';

import 'schedule_page_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<ScheduleProvider>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<GetIt>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<ScheduleUseCase>(onMissingStub: OnMissingStub.returnDefault)
])
void main() {
  final getIt = GetIt.instance;
  late MockScheduleProvider mockScheduleProvider;

  TestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    mockScheduleProvider = MockScheduleProvider();
    getIt.registerLazySingleton<ScheduleProvider>(
        () => ScheduleProvider(useCase: MockScheduleUseCase()));
  });

  tearDown(() {
    getIt.unregister<ScheduleProvider>();
  });

  Widget buildSchedulePage(ScheduleProvider scheduleProvider) {
    return MaterialApp(
      home: ChangeNotifierProvider<ScheduleProvider>(
        create: (_) => scheduleProvider,
        child: const SchedulePage(),
      ),
    );
  }

  group('SchedulePage widget test', () {
    testWidgets('Test header text', (WidgetTester tester) async {
      await tester.pumpWidget(buildSchedulePage(mockScheduleProvider));

      final headerText1 = find.text('JADWAL KONSUMSI');
      final headerText2 = find.text('OBAT KELASI BESI');

      expect(headerText1, findsOneWidget);
      expect(headerText2, findsOneWidget);
    });

    testWidgets('Test back button text', (WidgetTester tester) async {
      await tester.pumpWidget(buildSchedulePage(mockScheduleProvider));

      final backButton = find.widgetWithText(Button, 'Menu');
      expect(backButton, findsOneWidget);

      await tester.tap(backButton);
      await tester.pump();
    });

    testWidgets('Test add schedule button onPressed',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildSchedulePage(mockScheduleProvider));

      final addScheduleButton = find.widgetWithText(Button, 'Tambah Jadwal');
      expect(addScheduleButton, findsOneWidget);

      await tester.tap(addScheduleButton);
      await tester.pumpAndSettle();
      expect(find.byType(AddScheduleModal), findsOneWidget);
    });

    testWidgets('Test delete button onPressed', (WidgetTester tester) async {
      await tester.pumpWidget(buildSchedulePage(mockScheduleProvider));

      final deleteButtons = find.byType(IconButton);

      for (var i = 0; i < deleteButtons.evaluate().length; i++) {
        await tester.ensureVisible(deleteButtons.at(i));
        await tester.tap(deleteButtons.at(i));
        await tester.pump();
      }
    });

    testWidgets('should refresh schedules when refreshSchedules is called',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildSchedulePage(mockScheduleProvider));

      SchedulePageState state = tester.state(find.byType(SchedulePage));
      state.refreshSchedules();

      await tester.pump();

      expect(find.byType(SchedulePage), findsOneWidget);
    });

    testWidgets('should show an error message when snapshot has error',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        getIt.unregister<ScheduleProvider>();
        getIt.registerLazySingleton<ScheduleProvider>(
            () => mockScheduleProvider);

        when(mockScheduleProvider.getSchedulesByUserId()).thenAnswer((_) async {
          return Future.error('An error occurred');
        });

        await tester.pumpWidget(buildSchedulePage(mockScheduleProvider));

        await tester.pumpAndSettle();

        expect(find.text('Gagal mengambil data'), findsOneWidget);
        expect(find.text('Silakan kembali!'), findsOneWidget);

        await tester.tap(find.text('Kembali'));
      });
    });

    testWidgets('should display list of schedules when snapshot has completed',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        NotificationService().initNotification();
        getIt.unregister<ScheduleProvider>();
        getIt.registerLazySingleton<ScheduleProvider>(
            () => mockScheduleProvider);
        var testSchedules = [
          {'time': '08:00'},
          {'time': '12:00'},
          {'time': '18:00'},
        ];

        when(mockScheduleProvider.getSchedulesByUserId()).thenAnswer((_) async {
          return Future.value();
        });

        when(mockScheduleProvider.schedules).thenReturn(testSchedules);

        await tester.pumpWidget(buildSchedulePage(mockScheduleProvider));

        await tester.pump();

        for (var schedule in testSchedules) {
          expect(find.text(schedule['time']!), findsOneWidget);
        }
      });
    });
  });
}
