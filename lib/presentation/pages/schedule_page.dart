import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:talacare/core/constants/app_colors.dart';
import 'package:talacare/presentation/widgets/button.dart';
import 'package:talacare/core/enums/button_color_scheme_enum.dart';

class SchedulePage extends StatelessWidget {
  SchedulePage({super.key});

  final List<String> scheduleTimes = [
    '08.00',
    '09.00',
    '10.00',
    '23.00',
    '11.59',
    '20.20'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'JADWAL KONSUMSI',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontFamily: 'Digitalt',
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.96,
                    ),
                  ),
                  const Text(
                    'OBAT KELASI BESI',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontFamily: 'Digitalt',
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.96,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: scheduleTimes.length,
                      itemBuilder: (context, index) {
                        final String scheduleTime = scheduleTimes[index];
                        return Container(
                          margin: const EdgeInsets.only(
                              top: 20, left: 20, right: 20),
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 30),
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
                  ),
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
                    onTap: () {},
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
