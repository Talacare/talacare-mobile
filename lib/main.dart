import 'package:flutter/material.dart';
import 'package:talacare/core/constants/app_colors.dart';
import 'package:talacare/presentation/pages/home_page.dart';
import 'package:talacare/presentation/pages/jump_n_jump_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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
      home: const HomePage(),
      routes: {
        '/home': (context) => const HomePage(),
        '/jump_n_jump': (context) => const JumpNJumpPage(),
      },
    );
  }
}
