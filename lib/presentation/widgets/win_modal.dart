import 'package:flutter/material.dart';

class WinModal extends StatelessWidget {
  const WinModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Column(
          children: [
            Spacer(),
            SizedBox(
              width: 203,
              height: 50,
              child: Text(
                'SUSTER',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontFamily: 'Digitalt',
                  fontWeight: FontWeight.w500,
                  height: 0,
                  shadows: [
                    Shadow( // bottomLeft
                      offset: Offset(-1.5, -1.5),
                      color: const Color(0xFFB20D78)
                    ),
                    Shadow( // bottomRight
                      offset: Offset(3.5, -1.5),
                      color: const Color(0xFFB20D78)
                    ),
                    Shadow( // topRight
                      offset: Offset(1.5, 1.5),
                      color: const Color(0xFFB20D78)
                    ),
                    Shadow( // topLeft
                      offset: Offset(-1.5, 1.5),
                      color: const Color(0xFFB20D78)
                    ),
                  ]
                ),
              ),
            ),
            const SizedBox(height: 80),
            InkWell(
              key: const Key("nextButton"),
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: 282,
                height: 48,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 282,
                        height: 48,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 282,
                                height: 48,
                                decoration: ShapeDecoration(
                                  color: Color(0xFF7031FC),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 2,
                                      strokeAlign: BorderSide.strokeAlignOutside,
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(33),
                                  ),
                                  shadows: [
                                    BoxShadow(
                                      color: Color(0x26000000),
                                      blurRadius: 0,
                                      offset: Offset(0, 2),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 282,
                                height: 43,
                                decoration: ShapeDecoration(
                                  color: Color(0xFF9A4AFE),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(33),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 5,
                      top: 12,
                      child: SizedBox(
                        width: 269,
                        height: 24,
                        child: Text(
                          'Lanjut',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Digitalt',
                            fontWeight: FontWeight.w500,
                            height: 0,
                            letterSpacing: 0.96,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}
