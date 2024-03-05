import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:talacare/presentation/puzzle/puzzle_info.dart';
import 'package:talacare/presentation/widgets/next_info.dart';

class PuzzlePage extends StatelessWidget {
  const PuzzlePage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PuzzleInfo(),
            Gap(500),
            NextInfo(),
          ]
        ),
      )
    );
  }
}