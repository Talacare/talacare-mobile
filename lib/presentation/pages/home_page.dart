import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:talacare/core/constants/app_colors.dart';
import 'package:talacare/presentation/puzzle/timer_state.dart';
import 'package:talacare/presentation/widgets/game_card.dart';
import 'package:talacare/presentation/pages/puzzle_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildGreetingText(),
        ClipOval(
          key: const Key('user_picture'),
          child: SizedBox(
            width: 55,
            height: 55,
            child: Image.network(
              'https://image.lexica.art/full_jpg/7515495b-982d-44d2-9931-5a8bbbf27532',
            ),
          ),
        )
      ],
    );
  }

  TextStyle _getTextStyle(double height, Color color, double size) {
    return TextStyle(
      height: height,
      fontFamily: 'Digitalt',
      color: color,
      fontSize: size,
    );
  }

  Widget _buildGreetingText() {
    return Column(
      key: const Key('greeting'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome To',
          style: _getTextStyle(1, AppColors.white, 22),
        ),
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Text(
              'TALACARE',
              style: _getTextStyle(1.1, AppColors.lightPink, 39.5),
            ),
            Text(
              'TALACARE',
              style: _getTextStyle(1, AppColors.white, 38),
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildHeader(),
                const Gap(40),
                GameCard(
                  title: 'Jump N Jump',
                  imgPath: 'jump_n_jump_trailer.png',
                  key: const Key('jump_n_jump_card'),
                  onTap: () {},
                ),
                const Gap(30),
                GameCard(
                  title: 'Puzzle',
                  imgPath: 'puzzle_trailer.png',
                  key: const Key('puzzle_card'),
                  onTap: (){
                    final timerState = Provider.of<TimerState>(context, listen: false);
                    timerState.value = false;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PuzzlePage()),
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
