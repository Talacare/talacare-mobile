import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:talacare/core/constants/app_colors.dart';
import 'package:talacare/presentation/providers/schedule_provider.dart';
import 'package:talacare/presentation/widgets/add_schedule_modal.dart';
import 'package:talacare/presentation/widgets/button.dart';
import 'package:talacare/core/enums/button_color_scheme_enum.dart';
import 'package:talacare/injection.dart' as di;
import 'package:talacare/presentation/widgets/custom_notification.dart';
import 'package:talacare/presentation/widgets/delete_icon_button.dart';
import 'package:talacare/presentation/widgets/modal_button.dart';
import 'package:talacare/notification_service.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  SchedulePageState createState() => SchedulePageState();
}

class SchedulePageState extends State<SchedulePage> {
  late List<Map<String, String>> schedules;
  
  void refreshSchedules() {
    setState(() {});
  }

  void showNotification(String message, bool isSuccess) {
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

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Image.asset(
                  'assets/images/gagal_mengambil_data.png',
                  width: 75,
                  height: 75,
                )),
                const Gap(15),
                Center(
                  child: Text(
                    'Gagal mengambil data',
                    style: TextStyle(
                      color: AppColors.mildBlue,
                      fontSize: 28,
                      fontFamily: 'Digitalt',
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.96,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Silakan kembali!',
                    style: TextStyle(
                      color: AppColors.mildBlue,
                      fontSize: 28,
                      fontFamily: 'Digitalt',
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.96,
                    ),
                  ),
                ),
                const Gap(20), // Spacing between text and button
                Center(
                  child: ModalButton(
                      text: 'Kembali',
                      color: Colors.white,
                      borderColor: AppColors.coralPink,
                      textColor: AppColors.coralPink,
                      onTap: () => {
                            Navigator.of(context)
                              ..pop()
                              ..pop()
                          }),
                ),
              ],
            ),
          );
        });
  }

  Widget _buildListOfSchedules(BuildContext context) {
    return FutureBuilder(
      future: di.getIt<ScheduleProvider>().getSchedulesByUserId(),
      builder: (context, snapshot) {
        var scheduleProvider = di.getIt<ScheduleProvider>();
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          );
        } else if (scheduleProvider.isError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showBottomSheet(context);
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
          return LimitedBox(
            maxHeight: height - 310,
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
          _createNotification(schedules);

          return Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: schedules.length,
              itemBuilder: (context, index) {
                final String scheduleTime =
                    schedules[index]['time']!;
                
                return Container(
                  margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
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
                        scheduleId: scheduleProvider.schedules[index]['id']!,
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
      },
    );
  }

  void _createNotification(List<Map<String, String>> schedules) {
    NotificationService().cancelAllNotification();

    for (var i = 0; i < schedules.length; i++) {
      Map<String, String> schedule = schedules[i];
      NotificationService().scheduleNotificationHelper(
        id: i,
        payload: schedule["id"],
        scheduledTime: schedule["time"]!
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const Gap(20),
                  _buildTitle('JADWAL KONSUMSI'),
                  _buildTitle('OBAT KELASI BESI'),
                  _buildListOfSchedules(context),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          ],
        ),
      ),
    );
  }
}
