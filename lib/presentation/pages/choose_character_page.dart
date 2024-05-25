import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:talacare/core/enums/character_enum.dart';
import 'package:talacare/presentation/pages/jump_n_jump_page.dart';
import 'package:talacare/presentation/widgets/button.dart';
import 'package:talacare/presentation/widgets/character_card.dart';
import 'package:talacare/presentation/widgets/home_button.dart';

class ChooseCharacterPage extends StatefulWidget {
  const ChooseCharacterPage({super.key});

  @override
  State<ChooseCharacterPage> createState() => _ChooseCharacterState();
}

class _ChooseCharacterState extends State<ChooseCharacterPage> {
  Character? _character;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _buildMainContent(),
            _buildHomeButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeButton(BuildContext context) {
    return Positioned(
      top: 20.0,
      left: 20.0,
      child: HomeButton(
        onTap: () => Navigator.of(context).pop(),
      ),
    );
  }

  Widget _buildMainContent() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Pilih Karaktermu!',
              style: TextStyle(
                fontFamily: 'Digitalt',
                color: Colors.white,
                fontSize: 40,
              ),
            ),
            const Gap(50),
            _buildCharacterSelection(),
            const Gap(50),
            _buildStartButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCharacterSelection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CharacterCard(
          onTap: () => setState(() => _character = Character.boy),
          isSelected: _character == Character.boy,
          imageName: 'boy_head.png',
          characterName: 'Tala',
        ),
        const Gap(30),
        CharacterCard(
          onTap: () => setState(() => _character = Character.girl),
          isSelected: _character == Character.girl,
          imageName: 'girl_head.png',
          characterName: 'Talia',
        ),
      ],
    );
  }

  Widget _buildStartButton() {
    return Button(
      text: 'Mulai',
      onTap: () {
        if (_character == null) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => JumpNJumpPage(character: _character!),
          ),
        );
      },
    );
  }
}
