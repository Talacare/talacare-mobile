import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:talacare/core/enums/character_enum.dart';
import 'package:talacare/presentation/pages/jump_n_jump_page.dart';
import 'package:talacare/presentation/widgets/button.dart';
import 'package:talacare/presentation/widgets/character_card.dart';

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
        child: Center(
          child: SingleChildScrollView(
            child: Column(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CharacterCard(
                      onTap: () => setState(() {
                        _character = Character.boy;
                      }),
                      isSelected: _character == Character.boy,
                      imageName: 'boy_head.png',
                      characterName: 'Laki-Laki',
                    ),
                    const Gap(30),
                    CharacterCard(
                      onTap: () => setState(() {
                        _character = Character.girl;
                      }),
                      isSelected: _character == Character.girl,
                      imageName: 'girl_head.png',
                      characterName: 'Perempuan',
                    ),
                  ],
                ),
                const Gap(50),
                Button(
                  text: 'Mulai',
                  onTap: () {
                    if (_character == null) return;

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JumpNJumpPage(
                          character: _character!,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
