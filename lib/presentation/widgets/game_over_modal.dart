import 'package:flutter/material.dart';

class GameOverModal extends StatelessWidget {
  final int currentScore;
  final int highestScore;
  final VoidCallback onMainLagiPressed;
  final VoidCallback onMenuPressed;

  const GameOverModal({
    Key? key,
    required this.currentScore,
    required this.highestScore,
    required this.onMainLagiPressed,
    required this.onMenuPressed,
  }) : super(key: key);

  Widget _buildScoreContainer(String title, int score, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF5FCFFF),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 5.0),
          decoration: ShapeDecoration(
            color: const Color(0xFFC2FDFF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
          child: Text(
            '$score',
            style: const TextStyle(
              color: Color(0xFF228AED),
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(String text, Color color, Color borderColor,
      Color textColor, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 45,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                  color: borderColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(33),
                  ),
                ),
              ),
            ),
            Container(
              height: 40,
              width: 150,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.all(
                  Radius.circular(33),
                ),
                border: Border.all(
                  width: 2,
                  color: const Color(0xFFFF8080),
                ),
              ),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFFD3D8FF),
                  blurRadius: 10,
                  offset: Offset(0, 5),
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
                    color: const Color(0xFFDD67ED),
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
                _buildActionButton('Main Lagi', const Color(0xFFFF8080),
                    const Color(0xFFFFB8B8), Colors.white, onMainLagiPressed),
                const SizedBox(height: 5),
                _buildActionButton(
                    'Menu',
                    Colors.white,
                    const Color(0xFFFF8080),
                    const Color(0xFFFF8080),
                    onMenuPressed),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
