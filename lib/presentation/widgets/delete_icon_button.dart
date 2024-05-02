import 'package:flutter/material.dart';
import 'package:talacare/core/constants/app_colors.dart';
import 'package:talacare/presentation/providers/schedule_provider.dart';

class DeleteIconButton extends StatefulWidget {
  final ScheduleProvider scheduleProvider;
  final String scheduleId;
  final VoidCallback refreshSchedules;
  final Function(String, bool, String) showNotification;

  const DeleteIconButton({
    super.key,
    required this.scheduleProvider,
    required this.scheduleId,
    required this.refreshSchedules,
    required this.showNotification,
  });

  @override
  State<DeleteIconButton> createState() => _DeleteIconButtonState();
}

class _DeleteIconButtonState extends State<DeleteIconButton> {
  bool showLoading = false;

  void _deleteSchedule() {
    setState(() {
      showLoading = true;
    });

    widget.scheduleProvider.deleteSchedule(widget.scheduleId).then((_) {
      bool isSuccess = !widget.scheduleProvider.isError;
      String message = widget.scheduleProvider.message;

      if (!isSuccess) {
        setState(() {
          showLoading = false;
        });
      }

      widget.showNotification(message, isSuccess, widget.scheduleId);
      widget.refreshSchedules();
    });
  }

  @override
  Widget build(BuildContext context) {
    return showLoading
        ? CircularProgressIndicator(
            color: AppColors.darkPurple,
          )
        : IconButton(
            icon: const Icon(Icons.delete_outline),
            iconSize: 35,
            color: AppColors.darkPurple,
            onPressed: _deleteSchedule,
          );
  }
}
