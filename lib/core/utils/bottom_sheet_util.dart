import 'package:flutter/material.dart';
import 'package:talacare/core/constants/app_colors.dart';
import 'package:gap/gap.dart';
import 'package:talacare/presentation/widgets/modal_button.dart';

class BottomSheetUtil {
  static void showBottomSheet({
    required BuildContext context,
    required String title,
    required String description,
    required String textButton,
    required VoidCallback onTap,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/gagal_mengambil_data.png',
                width: 75,
                height: 75,
              ),
              const Gap(15),
              Text(
                title,
                style: TextStyle(
                  color: AppColors.mildBlue,
                  fontSize: 20,
                  fontFamily: 'Digitalt',
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.96,
                ),
                textAlign: TextAlign.center,
              ),
              const Gap(7),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  description,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    letterSpacing: 0.96,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Gap(20),
              Center(
                child: ModalButton(
                  text: textButton,
                  color: Colors.white,
                  borderColor: AppColors.coralPink,
                  textColor: AppColors.coralPink,
                  onTap: onTap,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
