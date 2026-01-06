import 'package:flutter/material.dart';

class MyAbout extends StatefulWidget {
  const MyAbout({super.key});

  @override
  State<MyAbout> createState() => _MyAboutState();
}

class _MyAboutState extends State<MyAbout> {
  static const Color primaryColor = Color.fromARGB(255, 113, 50, 202);

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
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: Container(
                width: 120,
                height: 120,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Image.asset(
                  'assets/images/myconcert.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'MyConcert App',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      const Text(
        'MyConcert App adalah platform digital yang menghadirkan pengalaman '
        'pemesanan tiket konser secara modern, cepat, dan terintegrasi dalam '
        'satu aplikasi. Aplikasi ini dirancang untuk menjawab kebutuhan '
        'masyarakat terhadap sistem pembelian tiket yang praktis, transparan, '
        'dan dapat diakses kapan saja serta di mana saja.\n\n'
        'Dengan antarmuka yang intuitif dan responsif, MyConcert App memudahkan '
        'pengguna dalam menemukan event, memilih tiket, hingga menyelesaikan '
        'transaksi secara aman. Selain itu, fitur riwayat pemesanan membantu '
        'pengguna mengelola tiket secara efisien.',
        textAlign: TextAlign.justify,
        style: TextStyle(fontSize: 14, height: 1.7, color: Colors.grey),
      ),
    );
  }
}
