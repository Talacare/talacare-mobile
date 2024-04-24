import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:talacare/core/constants/app_colors.dart';
import 'package:talacare/presentation/providers/schedule_provider.dart';
import 'package:talacare/presentation/widgets/add_schedule_modal.dart';
import 'package:talacare/presentation/widgets/button.dart';
import 'package:talacare/core/enums/button_color_scheme_enum.dart';
import 'package:talacare/injection.dart' as di;
import 'package:talacare/presentation/widgets/modal_button.dart';
import 'package:talacare/notification_service.dart';

class SchedulePage extends StatefulWidget {
  final NotificationService notificationService;
  final bool testing;

  const SchedulePage({super.key, required this.notificationService, required this.testing});

  @override
  SchedulePageState createState() => SchedulePageState();
}

class SchedulePageState extends State<SchedulePage> {
  void refreshSchedules() {
    setState(() {});
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
    
    widget.notificationService.cancelAllNotification();

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
        } else if (snapshot.hasError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showBottomSheet(context);
          });
          return Center(
            child: Container(),
          );
        } else {
          return Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: scheduleProvider.schedules.length,
              itemBuilder: (context, index) {
                final String scheduleTime =
                    scheduleProvider.schedules[index]['time']!;

                // Ignoring for testing purpose, cannot be tested
                if (!(widget.testing)) {
                  widget.notificationService.scheduleNotificationHelper(
                    id: index,
                    payload: scheduleProvider.schedules[index]['id']!,
                    scheduledTime: scheduleTime
                  );
                }
                
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
                      IconButton(
                        icon: const Icon(Icons.delete_outline),
                        iconSize: 35,
                        color: AppColors.darkPurple,
                        onPressed: () {},
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
