import 'package:flutter/material.dart';
import 'package:talacare/core/constants/app_colors.dart';
import 'package:talacare/core/enums/button_color_scheme_enum.dart';

class Button extends StatelessWidget {
  final String text;
  final ButtonColorScheme colorScheme;
  final void Function()? onTap;
  late Color bodyColor;
  late Color firstShadowColor;
  late Color secondShadowColor;

  Button({
    super.key,
    required this.text,
    this.onTap,
    this.colorScheme = ButtonColorScheme.green,
  });

  void getButtonColorScheme(ButtonColorScheme color){
    switch(color){
      case ButtonColorScheme.green: {
        bodyColor = AppColors.darkGreen;
        firstShadowColor = AppColors.mediumGreen;
        secondShadowColor = AppColors.lightGreen;
      }
      case ButtonColorScheme.purple: {
        bodyColor = const Color(0xFF7031FC);
        firstShadowColor = const Color(0x26000000);
        secondShadowColor = const Color(0xFF9A4AFE);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    getButtonColorScheme(colorScheme);
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 282,
        height: 48,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: SizedBox(
                width: 282,
                height: 48,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 282,
                        height: 48,
                        decoration: ShapeDecoration(
                          color: bodyColor,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 2,
                              strokeAlign: BorderSide.strokeAlignOutside,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(33),
                          ),
                          shadows: [
                            BoxShadow(
                              color: firstShadowColor,
                              blurRadius: 0,
                              offset: const Offset(0, 2),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 282,
                        height: 43,
                        decoration: ShapeDecoration(
                          color: secondShadowColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(33),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 5,
              top: 12,
              child: SizedBox(
                width: 269,
                height: 24,
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Digitalt',
                    fontWeight: FontWeight.w500,
                    height: 0,
                    letterSpacing: 0.96,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
