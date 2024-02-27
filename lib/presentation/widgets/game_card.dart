import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:talacare/core/constants/app_colors.dart';

class GameCard extends StatelessWidget {
  final String title;
  final String imgPath;

  const GameCard({
    Key? key,
    required this.title,
    required this.imgPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/$imgPath',
            ),
          ),
          const Gap(7),
          Text(
            title,
            style: const TextStyle(
              height: 1,
              fontFamily: 'Digitalt',
              color: AppColors.darkPurple,
              fontSize: 36,
            ),
          ),
        ],
      ),
    );
  }
}
