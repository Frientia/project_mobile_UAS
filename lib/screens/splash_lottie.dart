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
    return Scaffold(
      backgroundColor: const Color(0xfff3eaff),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animasi Lottie
            Lottie.asset(
              'assets/animations/Ticket_load.json',
              width: 300,
              height: 300,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 24),
            const Text(
              'MyConcert',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 196, 123, 228),
              ),
            ),
            const SizedBox(height: 16),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
