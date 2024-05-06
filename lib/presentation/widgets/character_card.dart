import 'package:flutter/material.dart';
import 'package:talacare/core/constants/app_colors.dart';

class CharacterCard extends StatelessWidget {
  final void Function() onTap;
  final bool isSelected;
  final String imageName;
  final String characterName;

  const CharacterCard({
    super.key,
    required this.onTap,
    required this.isSelected,
    required this.imageName,
    required this.characterName,
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/jump_n_jump/characters/$imageName'),
            const SizedBox(height: 10),
            Text(characterName,
                style: const TextStyle(color: Colors.white, fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
