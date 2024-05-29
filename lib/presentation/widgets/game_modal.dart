import 'package:flutter/material.dart';
import 'package:talacare/core/constants/app_colors.dart';
import 'package:talacare/presentation/widgets/modal_button.dart';

class GameModal extends StatelessWidget {
  final int currentScore;
  final int highestScore;
  final VoidCallback onMainLagiPressed;
  final VoidCallback onMenuPressed;
  final bool isPause;

  const GameModal({
    super.key,
    required this.currentScore,
    required this.highestScore,
    required this.onMainLagiPressed,
    required this.onMenuPressed,
    this.isPause = false,
  });

  Widget _buildScoreContainer(String title, int score) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.mediumBlue,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 5.0),
          decoration: ShapeDecoration(
            color: AppColors.lightBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
          child: Text(
            '$score',
            style: TextStyle(
              color: AppColors.mildBlue,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
      decoration: ShapeDecoration(
        color: AppColors.lightPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
      child: Text(
        isPause ? "Istirahat Dulu?" : "Yuk Main Lagi!",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () {
        if(isPause){
          onMainLagiPressed();
        }
        return Future.value(true);
      },
      child: Center(
        child: Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.lavender,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTitle(),
                  const SizedBox(height: 10),
                  _buildScoreContainer('Skor Terkini', currentScore),
                  _buildScoreContainer('Skor Tertinggi', highestScore),
                  const SizedBox(height: 15),
                  ModalButton(
                    text: isPause ? "Lanjutkan" : 'Main Lagi',
                    color: AppColors.coralPink,
                    borderColor: AppColors.softPink,
                    textColor: Colors.white,
                    onTap: onMainLagiPressed,
                  ),
                  const SizedBox(height: 5),
                  ModalButton(
                    text: isPause ? 'Akhiri' : 'Selesai',
                    color: Colors.white,
                    borderColor: AppColors.coralPink,
                    textColor: AppColors.coralPink,
                    onTap: onMenuPressed,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
