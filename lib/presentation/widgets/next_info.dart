import 'package:flutter/material.dart';
import 'package:talacare/core/enums/button_color_scheme_enum.dart';
import 'package:talacare/presentation/widgets/button.dart';

class NextInfo extends StatefulWidget {
  const NextInfo({super.key});

  @override  
  State<NextInfo> createState() => _NextInfoState();  
}

class _NextInfoState extends State<NextInfo> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Container(
        padding: const EdgeInsets.only(bottom: 20),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
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
                      Shadow(
                          // bottomLeft
                          offset: Offset(-1.5, -1.5),
                          color: Color(0xFFB20D78)),
                      Shadow(
                          // bottomRight
                          offset: Offset(3.5, -1.5),
                          color: Color(0xFFB20D78)),
                      Shadow(
                          // topRight
                          offset: Offset(1.5, 1.5),
                          color: Color(0xFFB20D78)),
                      Shadow(
                          // topLeft
                          offset: Offset(-1.5, 1.5),
                          color: Color(0xFFB20D78)),
                    ]),
              ),
            ),
            const SizedBox(height: 80),
            Button(
              key: const Key('nextButton'),
              text: 'Lanjut',
              colorScheme: ButtonColorScheme.purple,
              onTap: (){
                Navigator.pop(context);
              },
            )
          ]),
        ),
      ),
    );
  }
}