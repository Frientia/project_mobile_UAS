import 'package:flutter/material.dart';

class MyLauncherScreen extends StatefulWidget {
  const MyLauncherScreen({super.key});

  @override
  State<MyLauncherScreen> createState() => _MyLauncherScreenState();
}

class _MyLauncherScreenState extends State<MyLauncherScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Image.asset(
            'assets/images/logo_global.png',
            width: 200,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}