import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:talacare/core/constants/app_colors.dart';
import 'package:talacare/presentation/providers/schedule_provider.dart';
import 'package:talacare/presentation/widgets/add_schedule_modal.dart';
import 'package:talacare/presentation/widgets/button.dart';
import 'package:talacare/core/enums/button_color_scheme_enum.dart';
import 'package:talacare/injection.dart' as di;

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

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

  Widget _buildListOfSchedules() {
    return FutureBuilder(
      future: di.getIt<ScheduleProvider>().getSchedulesByUserId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          var scheduleProvider = di.getIt<ScheduleProvider>();
          return Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: scheduleProvider.schedules.length,
              itemBuilder: (context, index) {
                final String scheduleTime = scheduleProvider.schedules[index]['time']!;

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
                  _buildListOfSchedules(),
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
