import 'package:flutter/material.dart';

class MyAbout extends StatefulWidget {
  const MyAbout({super.key});

  @override
  State<MyAbout> createState() => _MyAboutState();
}

class _MyAboutState extends State<MyAbout> with SingleTickerProviderStateMixin {
  static const Color primaryColor = Color.fromARGB(255, 113, 50, 202);

  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _slide = Tween<Offset>(
      begin: const Offset(0, -0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _scale = Tween<double>(
      begin: 0.95,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SlideTransition(
              position: _slide,
              child: FadeTransition(
                opacity: _fade,
                child: Column(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/images/app_logo.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'MyConcert App',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            ScaleTransition(
              scale: _scale,
              child: FadeTransition(
                opacity: _fade,
                child: const Text(
                  'MyConcert App adalah platform digital yang menghadirkan pengalaman pemesanan '
                  'tiket konser secara modern, cepat, dan terintegrasi dalam satu aplikasi. '
                  'Aplikasi ini dikembangkan untuk menjawab kebutuhan pengguna akan sistem '
                  'pembelian tiket yang praktis, transparan, dan dapat diakses kapan saja serta '
                  'di mana saja.\n\n'
                  'Melalui MyConcert App, pengguna dapat dengan mudah menemukan berbagai event '
                  'konser, memilih jenis tiket dan jadwal pertunjukan, hingga menyelesaikan '
                  'transaksi secara aman melalui metode pembayaran digital yang tersedia. '
                  'Seluruh alur pemesanan dirancang dengan antarmuka yang intuitif dan responsif, '
                  'sehingga memberikan pengalaman pengguna yang nyaman dan efisien.\n\n'
                  'Tidak hanya berfokus pada kemudahan transaksi, MyConcert App juga menghadirkan '
                  'fitur riwayat pemesanan yang memungkinkan pengguna untuk memantau dan mengelola '
                  'seluruh tiket yang telah dibeli. Dengan dukungan teknologi autentikasi pengguna '
                  'dan sistem database real-time, aplikasi ini memastikan keamanan data serta '
                  'keandalan sistem dalam setiap proses transaksi.\n\n'
                  'MyConcert App dikembangkan dengan visi untuk menjadi solusi digital terpercaya '
                  'dalam industri hiburan, sekaligus menjadi jembatan antara penyelenggara event '
                  'dan penikmat musik dalam menghadirkan pengalaman konser yang lebih mudah, '
                  'cepat, dan terhubung.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.7,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
