import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:talacare/core/constants/app_colors.dart';
import 'package:talacare/main.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final String TALACARE_LOGO = 'assets/images/talacare-logo.png';

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(
      const Duration(seconds: 3),
          () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const MyHomePage(title: 'Test'),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.purple,
      body: SafeArea(
        child: Center(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                key: const Key('pink_layer'),
                width: 200,
                height: 70,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 50,
                      spreadRadius: 5,
                      color: AppColors.pink,
                    )
                  ],
                ),
              ),
              Image.asset(
                TALACARE_LOGO,
                key: const Key('talacare_logo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
