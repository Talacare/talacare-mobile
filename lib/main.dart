import 'package:flutter/material.dart';
import 'package:talacare/core/constants/app_colors.dart';
import 'package:talacare/presentation/pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TalaCare',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          background: AppColors.purple,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
