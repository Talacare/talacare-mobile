import 'package:flutter/material.dart';
import 'package:talacare/data/models/stage_state.dart';
import 'package:talacare/presentation/puzzle/circle_timer.dart';

class PuzzleInfo extends StatefulWidget {
  final StageState stageState;
  
  const PuzzleInfo({super.key, required this.stageState});

  @override
  State<PuzzleInfo> createState() => _PuzzleInfoState();
}

class _PuzzleInfoState extends State<PuzzleInfo> {
  final String puzzleImg = 'assets/images/perawat.png';

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

  Widget buildStarImage(int starValue) {
    if (starValue == 0) {
      return Image.asset(
        'assets/images/star_border.png',
        width: 30,
        height: 30,
      );
    } else if (starValue == 1) {
      return Image.asset(
        'assets/images/star_border_glow.png',
        width: 30,
        height: 30,
      );
    } else {
      return Image.asset(
        'assets/images/star.png',
        width: 30,
        height: 30,
      );
    }
  }

  Widget buildDownSide() {
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
