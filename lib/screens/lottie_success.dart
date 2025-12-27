import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_uas/pages/riwayat_pesanan.dart';

class MySuccess extends StatefulWidget {
  const MySuccess({super.key});

  @override
  State<MySuccess> createState() => _MySuccessState();
}

class _MySuccessState extends State<MySuccess> {
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
      MaterialPageRoute(builder: (context) => const MyRiwayat()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/Check_Mark.json',
              width: 300,
              height: 300,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
