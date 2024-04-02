import 'package:flutter/material.dart';
import 'package:talacare/core/constants/app_colors.dart';
import 'package:talacare/presentation/widgets/modal_button.dart';

class GameOverModal extends StatelessWidget {
  final int currentScore;
  final int highestScore;
  final VoidCallback onMainLagiPressed;
  final VoidCallback onMenuPressed;

  const GameOverModal({
    super.key,
    required this.currentScore,
    required this.highestScore,
    required this.onMainLagiPressed,
    required this.onMenuPressed,
  });

  Widget _buildScoreContainer(String title, int score, BuildContext context) {
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
                    "Yuk Main Lagi!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                _buildScoreContainer('Skor Terkini', currentScore, context),
                _buildScoreContainer('Skor Tertinggi', highestScore, context),
                const SizedBox(height: 15),
                ModalButton(
                  text: 'Main Lagi',
                  color: AppColors.coralPink,
                  borderColor: AppColors.softPink,
                  textColor: Colors.white,
                  onTap: onMainLagiPressed,
                ),
                const SizedBox(height: 5),
                ModalButton(
                  text: 'Menu',
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
    );
  }
}
