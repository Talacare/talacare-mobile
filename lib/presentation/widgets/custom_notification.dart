import 'package:flutter/material.dart';
import 'package:talacare/core/constants/app_colors.dart';

class CustomNotification {
  static void show(BuildContext context,
      {required String message, bool isSuccess = true}) {
    OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        key: const Key('custom_notification'),
        bottom: MediaQuery.of(context).size.height - 100,
        left: 10,
        right: 10,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSuccess ? AppColors.yellow : Colors.red,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 5,
                  color: Colors.black45,
                  spreadRadius: 2,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: isSuccess ? AppColors.purple : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);

    Future.delayed(const Duration(seconds: 2))
        .then((_) => overlayEntry.remove());
  }
}
