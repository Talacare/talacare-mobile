import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talacare/core/constants/app_colors.dart';
import 'package:talacare/data/models/schedule_model.dart';
import 'package:talacare/presentation/providers/schedule_provider.dart';
import 'package:talacare/presentation/widgets/custom_notification.dart';
import 'package:talacare/presentation/widgets/modal_button.dart';
import 'package:talacare/injection.dart' as di;

class AddScheduleModal extends StatefulWidget {
  final VoidCallback onScheduleAdded;

  const AddScheduleModal({super.key, required this.onScheduleAdded});

  @override
  State<AddScheduleModal> createState() => _AddScheduleModalState();
}

class _AddScheduleModalState extends State<AddScheduleModal> {
  DateTime selectedDate = DateTime.now();

  void _onDateChanged(DateTime newDate) {
    setState(() {
      selectedDate = newDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScheduleProvider model = di.getIt<ScheduleProvider>();
    return ChangeNotifierProvider<ScheduleProvider>.value(
      value: model,
      child: Center(
        child: Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.lavender,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 5.0),
                    decoration: ShapeDecoration(
                      color: AppColors.lightPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    child: const Text(
                      "Tambah Jadwal",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 200,
                    child: CupertinoTheme(
                      data: CupertinoThemeData(
                        textTheme: CupertinoTextThemeData(
                          dateTimePickerTextStyle: TextStyle(
                            fontSize: 32,
                            fontFamily: 'Digitalt',
                            color: AppColors.lightPurple,
                          ),
                        ),
                      ),
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.time,
                        use24hFormat: true,
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged: _onDateChanged,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Consumer<ScheduleProvider>(
                      builder: (context, scheduleProvider, _) {
                    return ModalButton(
                      text: 'Tambah',
                      color: AppColors.coralPink,
                      borderColor: AppColors.softPink,
                      textColor: Colors.white,
                      isLoading: scheduleProvider.isLoading,
                      onTap: () async {
                        ScheduleModel schedule = ScheduleModel(
                          hour: selectedDate.hour,
                          minute: selectedDate.minute,
                        );
                        await di
                            .getIt<ScheduleProvider>()
                            .createSchedule(schedule)
                            .then((_) {
                          bool isSuccess = !scheduleProvider.isError;
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            CustomNotification.show(
                              context,
                              message: scheduleProvider.message,
                              isSuccess: isSuccess,
                            );
                          });
                          if (!scheduleProvider.isError) {
                            Navigator.of(context).pop();
                          }
                          widget.onScheduleAdded();
                        });
                      },
                    );
                  }),
                  const SizedBox(height: 5),
                  ModalButton(
                    text: 'Kembali',
                    color: Colors.white,
                    borderColor: AppColors.coralPink,
                    textColor: AppColors.coralPink,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
