import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:talacare/core/constants/app_colors.dart';
import 'package:talacare/data/models/stage_state.dart';
import 'package:talacare/core/utils/analytics_engine_util.dart';
import 'package:talacare/injection.dart';
import 'package:talacare/presentation/pages/choose_character_page.dart';
import 'package:talacare/presentation/providers/auth_provider.dart';
import 'package:talacare/presentation/widgets/game_card.dart';
import 'package:talacare/presentation/pages/puzzle_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              getIt<AuthProvider>().user?.photoURL ??
                  'https://i.pinimg.com/736x/c0/74/9b/c0749b7cc401421662ae901ec8f9f660.jpg',
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
          style: _getTextStyle(1, Colors.white, 22),
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
              style: _getTextStyle(1, Colors.white, 38),
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
                  buttonName: "jump_n_jump_button",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChooseCharacterPage(),
                      ),
                    );
                  },
                ),
                const Gap(30),
                GameCard(
                  title: 'Puzzle',
                  imgPath: 'puzzle_trailer.png',
                  key: const Key('puzzle_card'),
                  buttonName: "puzzle_button",
                  onTap: () async {
                    AnalyticsEngineUtil.userPlaysPuzzle();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PuzzlePage(
                              stageState: StageState([1, 0, 0, 0], 1))),
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
