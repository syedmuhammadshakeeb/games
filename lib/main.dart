import 'package:flutter/material.dart';
import 'package:wheel_drag_game/letter_tracing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      home: LetterTracing(),
    );
  }
}

