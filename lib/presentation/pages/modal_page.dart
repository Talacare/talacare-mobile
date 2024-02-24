import 'package:flutter/material.dart';

class Modal extends StatelessWidget {
  const Modal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const String mainLagiAsset = 'assets/images/mainlagi.png';

    return Center(
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              child: Container(
                padding: const EdgeInsets.all(30.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 15),
                    const Text(
                      'skor terkini',
                      style: TextStyle(
                        color: Color(0xFF5FCFFF),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50.0, vertical: 5.0),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFC2FDFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                      child: const Text(
                        '999',
                        style: TextStyle(
                          color: Color(0xFF228AED),
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          height: 1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'skor tertinggi',
                      style: TextStyle(
                        color: Color(0xFF5FCFFF),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50.0, vertical: 5.0),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFC2FDFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                      child: const Text(
                        '999',
                        style: TextStyle(
                          color: Color(0xFF228AED),
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          height: 1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
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
                                  'main lagi',
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
                      onTap: () {
                        Navigator.of(context).pop();
                      },
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
                                  'menu',
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
            Positioned(
              top: -size.height * 0.14,
              left: 5,
              child: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  mainLagiAsset,
                  key: const Key('mainlagi'),
                  scale: 0.9,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
