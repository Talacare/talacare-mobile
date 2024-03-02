import 'package:flutter/material.dart';
import 'package:talacare/presentation/widgets/button.dart';

class WinModal extends StatelessWidget {
  const WinModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
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
                    color: Color(0xFFB20D78)
                  ),
                  Shadow( // bottomRight
                    offset: Offset(3.5, -1.5),
                    color: Color(0xFFB20D78)
                  ),
                  Shadow( // topRight
                    offset: Offset(1.5, 1.5),
                    color: Color(0xFFB20D78)
                  ),
                  Shadow( // topLeft
                    offset: Offset(-1.5, 1.5),
                    color: Color(0xFFB20D78)
                  ),
                ]
              ),
            ),
          ),
          SizedBox(height: 80),
          Button(
            key: Key('nextButton'),
            text: 'Lanjut',
            color: Color(0xFF7031FC),
            firstShadowColor: Color(0x26000000),
            secondShadowColor: Color(0xFF9A4AFE),
          )
        ]
      ),
    );
  }
}
