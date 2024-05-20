import 'package:flutter/material.dart';
import 'package:talacare/core/constants/app_colors.dart';
import 'package:talacare/presentation/widgets/pause_button.dart';

class ScoreAndPause extends StatelessWidget {
  final int highScore;
  final VoidCallback onPauseTap;

  const ScoreAndPause({
    super.key,
    required this.highScore,
    required this.onPauseTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 35.0,
          height: 35.0,
          decoration: BoxDecoration(
            color: AppColors.orange,
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Text(
              '🏆',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
        ),
        const SizedBox(width: 7),
        Text(
          '$highScore',
          style: TextStyle(
            color: AppColors.violet,
            fontSize: 35,
          ),
        ),
        const SizedBox(width: 15),
        PauseButton(onTap: onPauseTap),
      ],
    );
  }
}

