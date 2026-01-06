import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyAbout extends StatefulWidget {
  const MyAbout({super.key});

  @override
  State<MyAbout> createState() => _MyAboutState();
}

class _MyAboutState extends State<MyAbout> {
  static const Color primaryColor = Color.fromARGB(255, 113, 50, 202);

  Future<void> _openRepo() async {
    final uri = Uri.parse('https://github.com/USERNAME/REPO');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3eaff),
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'MyConcert App',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 6),

            const Text(
              'Versi 1.0.0',
              style: TextStyle(fontSize: 13, color: Colors.black),
            ),

            const SizedBox(height: 24),

            Container(
              width: 120,
              height: 120,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Image.asset(
                'assets/images/myconcert.png',
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'MyConcert App merupakan aplikasi pemesanan tiket konser berbasis mobile '
              'yang dirancang untuk memberikan pengalaman pengguna yang cepat, aman, '
              'dan terintegrasi. Aplikasi ini memungkinkan pengguna untuk menjelajahi '
              'berbagai event konser, melakukan pembelian tiket secara digital, serta '
              'mengelola riwayat transaksi dengan mudah.\n\n'
              'Dengan mengadopsi teknologi modern dan antarmuka yang intuitif, '
              'MyConcert App hadir sebagai solusi digital yang menjembatani '
              'penyelenggara event dan penikmat musik dalam satu platform terpadu.',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 14, height: 1.7, color: Colors.grey),
            ),

            const SizedBox(height: 24),

            _copyrightInfo(),

            const SizedBox(height: 15),

            GestureDetector(
              onTap: _openRepo,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Text(
                  'Lisensi',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _copyrightInfo() {
    return const Center(
      child: Text(
        '© 2025–2026 MyConcert Id, All Rights Reserved.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 13.5,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
          height: 1.5,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
