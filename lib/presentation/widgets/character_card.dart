import 'package:flutter/material.dart';
import 'package:talacare/core/constants/app_colors.dart';

class CharacterCard extends StatelessWidget {
  final void Function() onTap;
  final bool isSelected;
  final String imageName;

  const CharacterCard({
    super.key,
    required this.onTap,
    required this.isSelected,
    required this.imageName,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: const Key('character_card'),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.purple,
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? AppColors.yellow.withOpacity(0.8)
                  : Colors.transparent,
              spreadRadius: 10,
              blurRadius: 7,
            ),
          ],
        ),
        child: Image.asset('assets/images/jump_n_jump/characters/$imageName'),
      ),
    );
  }
}
