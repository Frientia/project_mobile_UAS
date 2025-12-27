import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_uas/pages/login_page.dart';

class SplashLottie extends StatefulWidget {
  const SplashLottie({super.key});

  @override
  State<SplashLottie> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashLottie> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
