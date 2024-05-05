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
  const testSchedules = [
    {'id': '1', 'time': '08:00'},
    {'id': '2', 'time': '12:00'},
    {'id': '3', 'time': '18:00'},
  ];

  TestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    mockScheduleProvider = MockScheduleProvider();
    when(mockScheduleProvider.schedules).thenReturn(testSchedules);
    getIt.registerLazySingleton<ScheduleProvider>(() => mockScheduleProvider);
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
      NotificationService().initNotification();
      await tester.pumpWidget(buildSchedulePage(mockScheduleProvider));
      await tester.pump(const Duration(seconds: 3));

      final headerText1 = find.text('JADWAL KONSUMSI');
      final headerText2 = find.text('OBAT KELASI BESI');

      expect(headerText1, findsOneWidget);
      expect(headerText2, findsOneWidget);
    });

    testWidgets('Test back button text', (WidgetTester tester) async {
      NotificationService().initNotification();
      await tester.pumpWidget(buildSchedulePage(mockScheduleProvider));
      await tester.pump(const Duration(seconds: 3));

      final backButton = find.widgetWithText(Button, 'Menu');
      expect(backButton, findsOneWidget);

      await tester.tap(backButton);
      await tester.pump();
    });

    testWidgets('Test add schedule button onPressed',
        (WidgetTester tester) async {
      NotificationService().initNotification();
      await tester.pumpWidget(buildSchedulePage(mockScheduleProvider));

      final addScheduleButton = find.widgetWithText(Button, 'Tambah Jadwal');
      expect(addScheduleButton, findsOneWidget);

      await tester.tap(addScheduleButton);
      await tester.pumpAndSettle();
      expect(find.byType(AddScheduleModal), findsOneWidget);
    });

    testWidgets('Test delete button onPressed', (WidgetTester tester) async {
      NotificationService().initNotification();
      await tester.pumpWidget(buildSchedulePage(mockScheduleProvider));
      await tester.pump(const Duration(seconds: 3));

      final deleteButtons = find.byType(IconButton);

      for (var i = 0; i < deleteButtons.evaluate().length; i++) {
        await tester.ensureVisible(deleteButtons.at(i));
        await tester.tap(deleteButtons.at(i));
        await tester.pump();
        await tester.pump(const Duration(seconds: 3));
      }
    });

    testWidgets('should refresh schedules when refreshSchedules is called',
        (WidgetTester tester) async {
      NotificationService().initNotification();
      await tester.pumpWidget(buildSchedulePage(mockScheduleProvider));
      await tester.pump(const Duration(seconds: 3));

      SchedulePageState state = tester.state(find.byType(SchedulePage));
      state.refreshSchedules();

      await tester.pump();
      await tester.pump(const Duration(seconds: 3));

      expect(find.byType(SchedulePage), findsOneWidget);
    });

    testWidgets('should show notification when showNotification is called',
        (WidgetTester tester) async {
      NotificationService().initNotification();
      await tester.pumpWidget(buildSchedulePage(mockScheduleProvider));
      await tester.pump(const Duration(seconds: 3));

      SchedulePageState state = tester.state(find.byType(SchedulePage));
      state.showNotification("Test Message", true, "payload");

      await tester.pump();
      await tester.pump(const Duration(seconds: 3));
    });

    testWidgets('should show an error message when snapshot has error',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        when(mockScheduleProvider.getSchedulesByUserId()).thenAnswer((_) async {
          return Future.value();
        });

        when(mockScheduleProvider.isError).thenReturn(true);

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
        when(mockScheduleProvider.getSchedulesByUserId()).thenAnswer((_) async {
          return Future.value();
        });

        when(mockScheduleProvider.deleteSchedule(any)).thenAnswer((_) async {
          return Future.value();
        });

        await tester.pumpWidget(buildSchedulePage(mockScheduleProvider));

        await tester.pump();

        for (var schedule in testSchedules) {
          expect(find.text(schedule['time']!), findsOneWidget);
        }
      });
    });

    testWidgets('should display message when there are no schedules',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        when(mockScheduleProvider.getSchedulesByUserId()).thenAnswer((_) async {
          return Future.value();
        });

        when(mockScheduleProvider.schedules).thenReturn([]);

        await tester.pumpWidget(buildSchedulePage(mockScheduleProvider));

        await tester.pump();

        expect(find.text('Anda belum'), findsOneWidget);
        expect(find.text('memiliki jadwal!'), findsOneWidget);
      });
    });
  });
}