import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_uas/screens/splash_screen1.dart';

class MyLauncherScreen extends StatefulWidget {
  const MyLauncherScreen({super.key});

  @override
  State<MyLauncherScreen> createState() => _MyLauncherScreenState();
}

class _MyLauncherScreenState extends State<MyLauncherScreen> {
  Timer? _timer;

   @override
  void initState() {
    super.initState();

    _timer = Timer(const Duration(seconds: 2), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const SplashScreen1(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
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