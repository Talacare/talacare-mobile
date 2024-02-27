import 'package:flutter/material.dart';
import 'package:talacare/core/constants/app_colors.dart';
import 'package:talacare/presentation/puzzle/circle_timer.dart';

class PuzzleInfo extends StatefulWidget {
  const PuzzleInfo({Key? key}) : super(key: key);

  @override
  State<PuzzleInfo> createState() => _PuzzleInfoState();
}

class _PuzzleInfoState extends State<PuzzleInfo> {
  final String puzzleImg = 'assets/images/perawat.png';
  final List<int> starList = [2, 2, 1, 0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.purple,
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(50),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: List.generate(
                        starList.length,
                        (index) {
                          if (starList[index] == 0) {
                            return Image.asset(
                              'assets/images/star_border.png',
                              width: 30,
                              height: 30,
                            );
                          } else if (starList[index] == 1) {
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
                        },
                      ),
                    ),
                    Container(
                        alignment: Alignment.centerRight,
                        child: const Text(
                          'TERTINGGI: 75',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                              fontFamily: 'Digitalt'),
                        ))
                  ],
                ),
                Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const CircleTimer(),
                            Container(
                                alignment: Alignment.centerRight,
                                child: const Text(
                                  'SISA WAKTU',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                      fontFamily: 'Digitalt'),
                                )),
                          ],
                        ),
                        Image.asset(
                          'assets/images/perawat.png',
                          width:
                              100,
                          height:
                              100,
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ));
  }
}
