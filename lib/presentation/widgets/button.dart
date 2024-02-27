import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;

  const Button({
    Key? key,
    required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        key: const Key("nextButton"),
        onTap: () {
            Navigator.of(context).pop();
        },
        child: SizedBox(
            width: 282,
            height: 48,
            child: Stack(
                children: [
                    Positioned(
                        left: 0,
                        top: 0,
                        child: SizedBox(
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
                                                color: const Color(0xFF7031FC),
                                                shape: RoundedRectangleBorder(
                                                    side: const BorderSide(
                                                        width: 2,
                                                        strokeAlign: BorderSide.strokeAlignOutside,
                                                        color: Colors.white,
                                                    ),
                                                    borderRadius: BorderRadius.circular(33),
                                                ),
                                                shadows: const [
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
                                                color: const Color(0xFF9A4AFE),
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
                                text,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
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
    );
  }
}
