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

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
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
              const Text(
                'Skor Terkini',
                style: TextStyle(
                  color: Color(0xFF5FCFFF),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
              const SizedBox(height: 5),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50.0, vertical: 5.0),
                decoration: ShapeDecoration(
                  color: const Color(0xFFC2FDFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                child: Text(
                  '$currentScore',
                  style: const TextStyle(
                    color: Color(0xFF228AED),
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Skor Tertinggi',
                style: TextStyle(
                  color: Color(0xFF5FCFFF),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
              const SizedBox(height: 5),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50.0, vertical: 5.0),
                decoration: ShapeDecoration(
                  color: const Color(0xFFC2FDFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                child: Text(
                  '$highestScore',
                  style: const TextStyle(
                    color: Color(0xFF228AED),
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              InkWell(
                onTap: onMainLagiPressed,
                child: SizedBox(
                  height: 45,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: 40,
                          width: 150,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFB8B8),
                            borderRadius: BorderRadius.all(
                              Radius.circular(33),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 150,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF8080),
                          borderRadius: BorderRadius.all(
                            Radius.circular(33),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Main Lagi',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
              InkWell(
                onTap: onMenuPressed,
                child: SizedBox(
                  height: 45,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: 40,
                          width: 150,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFF8080),
                            borderRadius: BorderRadius.all(
                              Radius.circular(33),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(33),
                          ),
                          border: Border.all(
                            width: 2,
                            color: const Color(0xFFFF8080),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Menu',
                            style: TextStyle(
                              color: Color(0xFFFF8080),
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
