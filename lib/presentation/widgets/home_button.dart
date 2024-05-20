import 'package:flutter/material.dart';
import 'package:talacare/core/constants/app_colors.dart';

class HomeButton extends StatelessWidget {
  final void Function() onTap;

  const HomeButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    const double size = 40;

    return InkWell(
      key: const Key('home_button'),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Stack(
          children: [
            Container(
              key: const Key('shadow_layer'),
              width: size,
              height: size,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.darkGreen,
              ),
            ),
            Container(
              key: const Key('main_layer'),
              width: size,
              height: size - 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.mediumGreen,
              ),
              child: const Icon(
                key: Key('home_icon'),
                Icons.home,
                color: Colors.white,
                size: size - 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
