import 'package:flutter/material.dart';
import 'package:talacare/core/constants/app_colors.dart';

class ModalButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color borderColor;
  final Color textColor;
  final VoidCallback onTap;
  final bool isLoading;

  const ModalButton({
    super.key,
    required this.text,
    required this.color,
    required this.borderColor,
    required this.textColor,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      child: SizedBox(
        height: 45,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                  color: borderColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(33),
                  ),
                ),
              ),
            ),
            Container(
              height: 40,
              width: 150,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.all(
                  Radius.circular(33),
                ),
                border: Border.all(
                  width: 2,
                  color: AppColors.coralPink,
                ),
              ),
              child: Center(
                child: isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : Text(
                        text,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 22,
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
