import 'package:flutter/material.dart';
import 'package:talacare/presentation/widgets/button.dart';

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
            Button(text: "Lanjut"),
          ]
        ),
      ),
    );
  }
}
