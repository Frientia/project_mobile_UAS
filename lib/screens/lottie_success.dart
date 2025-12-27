import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_uas/pages/home_page.dart';
import 'package:mobile_uas/pages/riwayat_pesanan.dart';

class MySuccess extends StatefulWidget {
  const MySuccess({super.key});

  @override
  State<MySuccess> createState() => _MySuccessState();
}

class _MySuccessState extends State<MySuccess> {
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
              repeat: true,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 220,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 113, 50, 202),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const HomePage()),
                    (route) => false,
                  );
                },
                child: Text(
                  'Kemabli ke Home',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: 220,
              height: 40,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  side: const BorderSide(
                    color: Color.fromARGB(255, 113, 50, 202),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const MyRiwayat()),
                  );
                },
                child: const Text('Lihat Riwayat Pesanan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
