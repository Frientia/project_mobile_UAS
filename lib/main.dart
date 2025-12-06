import 'package:flutter/material.dart';
import 'screens/splash_screen3.dart';

void main() {
  runApp(const MyProject());
}

class MyProject extends StatelessWidget {
  const MyProject({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyConcert',
      debugShowCheckedModeBanner: false,
      home: SplashScreen3(),
    );
  }
}
