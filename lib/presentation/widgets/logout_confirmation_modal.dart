import 'package:flutter/material.dart';
import 'package:talacare/core/constants/app_colors.dart';
import 'package:talacare/injection.dart';
import 'package:talacare/presentation/providers/auth_provider.dart';
import 'package:talacare/presentation/widgets/modal_button.dart';

class LogoutConfirmationModal extends StatelessWidget {
  const LogoutConfirmationModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFFD3D8FF),
                  blurRadius: 10,
                  offset: Offset(0, 5),
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
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontFamily: 'Digitalt',
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(text: "Anda yakin\n"),
                        TextSpan(text: "ingin keluar?"),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ModalButton(
                  text: 'Iya',
                  color: AppColors.coralPink,
                  borderColor: AppColors.softPink,
                  textColor: Colors.white,
                  onTap: () async {
                    Navigator.of(context).pop();
                    await getIt<AuthProvider>().logOut();
                  },
                ),
                const SizedBox(height: 5),
                ModalButton(
                  text: 'Tidak',
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
    );
  }
}
