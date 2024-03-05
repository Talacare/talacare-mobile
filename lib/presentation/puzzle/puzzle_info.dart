import 'package:flutter/material.dart';
import 'package:talacare/presentation/puzzle/circle_timer.dart';

class PuzzleInfo extends StatefulWidget {
  const PuzzleInfo({super.key});

  @override
  State<PuzzleInfo> createState() => _PuzzleInfoState();
}

class _PuzzleInfoState extends State<PuzzleInfo> {
  final String puzzleImg = 'assets/images/perawat.png';
  final List<int> starList = [2, 2, 1, 0];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left : 50, right: 50, top: 20, bottom: 30),
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
            starList.length,
            (index) => buildStarImage(starList[index]),
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
