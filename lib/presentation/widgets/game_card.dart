import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:talacare/core/constants/app_colors.dart';
import 'package:talacare/presentation/widgets/button.dart';

class GameCard extends StatelessWidget {
  final String title;
  final String imgPath;
  final VoidCallback onTap;
  final String buttonName;

  const GameCard({
    super.key,
    required this.title,
    required this.imgPath,
    required this.onTap,
    required this.buttonName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        children: [
          ClipRRect(
            key: const Key('game_image'),
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/$imgPath',
            ),
          ),
          const Gap(7),
          Text(
            title,
            key: const Key('game_title'),
            style: TextStyle(
              height: 1,
              fontFamily: 'Digitalt',
              color: AppColors.darkPurple,
              fontSize: 36,
            ),
          ),
          const Gap(20),
          Button(
            key: Key(buttonName),
            text: 'Main',
            onTap: onTap,
          )
        ],
      ),
    );
  }
}
