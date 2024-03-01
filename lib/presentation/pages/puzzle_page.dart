import 'package:flutter/material.dart';
import 'package:talacare/core/constants/app_colors.dart';

class PuzzlePage extends StatelessWidget {
  const PuzzlePage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          background: AppColors.purple,
        ),
        useMaterial3: true,
      ),
      home: const Row(),
    );
  }
}
