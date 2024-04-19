import 'package:flutter/material.dart';
import 'package:talacare/core/constants/app_colors.dart';
import 'package:talacare/injection.dart';
import 'package:talacare/presentation/widgets/logout_confirmation_modal.dart';
import 'package:talacare/presentation/widgets/modal_button.dart';
import 'package:talacare/presentation/providers/auth_provider.dart';

class ProfileModal extends StatelessWidget {
  const ProfileModal({
    super.key,
  });

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
                  child: const Text(
                    "Profil Anda",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CircleAvatar(
                  key: const Key('user_picture'),
                  backgroundImage: NetworkImage(
                    getIt<AuthProvider>().user?.photoURL ??
                        'https://i.pinimg.com/736x/c0/74/9b/c0749b7cc401421662ae901ec8f9f660.jpg',
                  ),
                  radius: 80,
                ),
                const SizedBox(height: 10),
                Text(
                  key: const Key('user_name'),
                  getIt<AuthProvider>().user?.name ?? "-",
                  style: TextStyle(
                    color: AppColors.mildBlue,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  key: const Key('user_email'),
                  getIt<AuthProvider>().user?.email ?? "-",
                  style: TextStyle(
                    color: AppColors.mediumBlue,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),
                ModalButton(
                  text: 'Logout',
                  color: AppColors.coralPink,
                  borderColor: AppColors.softPink,
                  textColor: Colors.white,
                  onTap: () {
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          const LogoutConfirmationModal(),
                    );
                  },
                ),
                const SizedBox(height: 5),
                ModalButton(
                  text: 'Kembali',
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
