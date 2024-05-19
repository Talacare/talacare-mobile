import 'package:flutter/material.dart';
import 'package:talacare/core/constants/app_colors.dart';

class PauseButton extends StatelessWidget {
  final void Function() onTap;

  const PauseButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: const Key('pause_button'),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.orange,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Container(
              key: const Key('shadow_layer'),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.darkGreen,
              ),
            ),
            Container(
              key: const Key('main_layer'),
              width: 50,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.mediumGreen,
              ),
              child: const Icon(
                key: Key('pause_icon'),
                Icons.pause,
                color: Colors.white,
                size: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
