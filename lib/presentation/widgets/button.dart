import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:talacare/core/enums/button_color_scheme_enum.dart';
import 'package:talacare/core/utils/button_color_util.dart';

class Button extends StatelessWidget {
  final String text;
  final ButtonColorScheme colorScheme;
  final void Function()? onTap;
  final bool isLoading;
  final IconData? icon;

  const Button(
      {super.key,
      required this.text,
      this.onTap,
      this.colorScheme = ButtonColorScheme.green,
      this.icon,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    final bodyColor = ButtonColorUtil.getBodyColor(colorScheme);
    final firstShadowColor = ButtonColorUtil.getFirstShadowColor(colorScheme);
    final secondShadowColor = ButtonColorUtil.getSecondShadowColor(colorScheme);

    Widget buildLoadingIndicator() {
      return Center(
        child: Container(
          width: 24,
          height: 24,
          padding: const EdgeInsets.all(2.0),
          child: const CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 3,
          ),
        ),
      );
    }

    Widget buildText() {
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: Colors.white,
              ),
              const Gap(5)
            ],
            Flexible(child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Digitalt',
                fontWeight: FontWeight.w500,
                height: 0,
                letterSpacing: 0.96,
              ),
            ),
        )],
        ),
      );
    }

    return InkWell(
      onTap: isLoading ? null : onTap,
      child: SizedBox(
        width: 282,
        height: 48,
        child: Stack(
          children: [
            Container(
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
            Container(
              height: 43,
              decoration: ShapeDecoration(
                color: secondShadowColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(33),
                ),
              ),
            ),
            isLoading ? buildLoadingIndicator() : buildText()
          ],
        ),
      ),
    );
  }
}
