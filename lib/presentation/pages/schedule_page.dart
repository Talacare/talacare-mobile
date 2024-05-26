import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:talacare/core/constants/app_colors.dart';
import 'package:talacare/core/utils/bottom_sheet_util.dart';
import 'package:talacare/presentation/providers/schedule_provider.dart';
import 'package:talacare/presentation/widgets/add_schedule_modal.dart';
import 'package:talacare/presentation/widgets/button.dart';
import 'package:talacare/core/enums/button_color_scheme_enum.dart';
import 'package:talacare/injection.dart' as di;
import 'package:talacare/presentation/widgets/custom_notification.dart';
import 'package:talacare/presentation/widgets/delete_icon_button.dart';
import 'package:talacare/presentation/widgets/modal_button.dart';
import 'package:talacare/domain/repositories/notification_adapter.dart';
import 'package:talacare/data/repositories/schedule_notification_adapter.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  SchedulePageState createState() => SchedulePageState();
}

class SchedulePageState extends State<SchedulePage> {
  late List<Map<String, String>> schedules;
  NotificationAdapter scheduleNotification = ScheduleNotificationAdapter();

  Future<void> refreshSchedules() async {
    await di.getIt<ScheduleProvider>().getSchedulesByUserId();
  }

  void showNotification(String message, bool isSuccess, String payload) {
    if (isSuccess) {
      scheduleNotification.deleteNotification(payload);
    }

    CustomNotification.show(
      context,
      message: message,
      isSuccess: isSuccess,
    );
  }

  Widget _buildTitle(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 28,
        fontFamily: 'Digitalt',
        fontWeight: FontWeight.w500,
        letterSpacing: 0.96,
      ),
    );
  }

  Widget _buildFlavorText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontFamily: 'Digitalt',
        fontWeight: FontWeight.w300,
        letterSpacing: 0.96,
      ),
    );
  }

  Widget _buildListOfSchedules(
      BuildContext context, ScheduleProvider scheduleProvider) {
    if (scheduleProvider.isLoading) {
      return const Expanded(
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    } else if (scheduleProvider.isError) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        BottomSheetUtil.showBottomSheet(
          context: context,
          title: 'Gagal mengambil data',
          description: 'Silakan kembali!',
          textButton: 'Kembali',
          onTap: () => {
            Navigator.of(context)
              ..pop()
              ..pop()
          },
        );
      });
      return Center(
        child: Container(),
      );
    } else if (scheduleProvider.schedules.isEmpty) {
      double height = MediaQuery.of(context).size.height;
      double gapValue = 0;
      if (height > 450) {
        gapValue = 20;
      }
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/jadwal_kosong.png',
                width: height / 4,
                height: height / 4,
              ),
              Gap(gapValue),
              _buildFlavorText('Anda belum'),
              _buildFlavorText('memiliki jadwal!'),
            ],
          ),
        ),
      );
    } else {
      schedules = scheduleProvider.schedules;
      scheduleNotification.createNotification(schedules);

      return Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: schedules.length,
          itemBuilder: (context, index) {
            final String scheduleTime = schedules[index]['time']!;

            return Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    scheduleTime,
                    style: TextStyle(
                      color: AppColors.darkPurple,
                      fontSize: 35,
                      fontFamily: 'Digitalt',
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.96,
                    ),
                  ),
                  DeleteIconButton(
                    scheduleProvider: scheduleProvider,
                    scheduleId: schedules[index]['id']!,
                    refreshSchedules: refreshSchedules,
                    showNotification: showNotification,
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
  }

  @override
  void initState() {
    refreshSchedules();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScheduleProvider model = di.getIt<ScheduleProvider>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Gap(20),
            _buildTitle('JADWAL KONSUMSI'),
            _buildTitle('OBAT KELASI BESI'),
            ChangeNotifierProvider<ScheduleProvider>.value(
                value: model,
                child: Consumer<ScheduleProvider>(
                    builder: (context, scheduleProvider, _) =>
                        _buildListOfSchedules(context, scheduleProvider))),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(10),
            Button(
              text: 'Tambah Jadwal',
              colorScheme: ButtonColorScheme.purple,
              icon: Icons.add,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      AddScheduleModal(onScheduleAdded: refreshSchedules),
                );
              },
            ),
            const Gap(20),
            Button(
              text: 'Menu',
              colorScheme: ButtonColorScheme.purple,
              icon: Icons.arrow_back,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}
