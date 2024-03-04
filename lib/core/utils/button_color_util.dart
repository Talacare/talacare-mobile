import 'package:flutter/material.dart';
import 'package:talacare/core/constants/app_colors.dart';
import 'package:talacare/core/enums/button_color_scheme_enum.dart';

class ButtonColorUtil {
  static Color getBodyColor(ButtonColorScheme colorScheme) {
    switch (colorScheme) {
      case ButtonColorScheme.green:
        return AppColors.darkGreen;
      case ButtonColorScheme.purple:
        return const Color(0xFF7031FC);
      default:
        return Colors.transparent; // Default color
    }
  }

  static Color getFirstShadowColor(ButtonColorScheme colorScheme) {
    switch (colorScheme) {
      case ButtonColorScheme.green:
        return AppColors.mediumGreen;
      case ButtonColorScheme.purple:
        return const Color(0x26000000);
      default:
        return Colors.transparent; // Default color
    }
  }

  static Color getSecondShadowColor(ButtonColorScheme colorScheme) {
    switch (colorScheme) {
      case ButtonColorScheme.green:
        return AppColors.lightGreen;
      case ButtonColorScheme.purple:
        return const Color(0xFF9A4AFE);
      default:
        return Colors.transparent; // Default color
    }
  }
}
