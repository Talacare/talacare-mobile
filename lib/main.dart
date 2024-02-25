import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:talacare/presentation/jump_n_jump/jump_n_jump.dart';
import 'package:talacare/presentation/pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Jump N Jump',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashPage());
  }
}

final Game game = JumpNJump();

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: GameWidget(
          // hot reload in development mode,
          game: kReleaseMode ? game : JumpNJump(),
        ),
      ),
    );
  }
}
