import 'package:flutter/material.dart';
import 'package:talacare/data/models/stage_state.dart';
import 'package:talacare/presentation/puzzle/info/circle_timer.dart';

class PuzzleInfo extends StatefulWidget {
  final StageState stageState;

  const PuzzleInfo({super.key, required this.stageState});

  @override
  State<PuzzleInfo> createState() => _PuzzleInfoState();
}

class _PuzzleInfoState extends State<PuzzleInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 30),
      child: Column(
        children: [
          buildStarRow(),
          buildDownSide(),
        ],
      ),
    );
  }

  Widget buildStarRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: List.generate(
            widget.stageState.starList.length,
            (index) => buildStarImage(widget.stageState.starList[index]),
          ),
        ),
        const Text(
          'TERTINGGI: 75',
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.normal,
              color: Colors.white,
              fontFamily: 'Digitalt'),
        )
      ],
    );
  }

  // 0 = future stage
  // 1 = current stage
  // 2 = win stage
  // 3 = lose stage
  Widget buildStarImage(int starValue) {
    if (starValue == 0) {
      return Image.asset(
        'assets/images/puzzle_star/star_border.png',
        width: 30,
        height: 30,
      );
    } else if (starValue == 1) {
      return Image.asset(
        'assets/images/puzzle_star/star_border_glow.png',
        width: 30,
        height: 30,
      );
    } else if (starValue == 2) {
      return Image.asset(
        'assets/images/puzzle_star/star_win.png',
        width: 30,
        height: 30,
      );
    } else {
      return Image.asset(
        'assets/images/puzzle_star/star_lose.png',
        width: 30,
        height: 30,
      );
    }
  }

  Widget buildDownSide() {
    String puzzleImg = widget.stageState.images[widget.stageState.stage - 1].image;

    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            children: [
              CircleTimer(),
              Text(
                'SISA WAKTU',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                    fontFamily: 'Digitalt'),
              ),
            ],
          ),
          Image.asset(
            puzzleImg,
            width: 100,
            height: 100,
          ),
        ],
      ),
    );
  }
}
