import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth > 600;
          final iconSize = isTablet ? 120.0 : 80.0;
          final titleSize = isTablet ? 36.0 : 28.0;
          final subtitleSize = isTablet ? 20.0 : 16.0;

          return Center(
            child: SingleChildScrollView(
              child: Container(
                width: size.width * 0.9,
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.person_add_alt_1_outlined,
                      size: iconSize,
                      color: const Color.fromARGB(255, 113, 50, 202),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Register",
                      style: TextStyle(
                        fontSize: titleSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Silakan isi data untuk membuat akun",
                      style: TextStyle(fontSize: subtitleSize),
                    ),
                    const SizedBox(height: 20),
                    // Nama Lengkap
                    TextField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Nama Lengkap',
                        hintText: 'Masukkan nama Anda',
                        prefixIcon: const Icon(Icons.person_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // No Handphone
                    TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'No Handphone',
                        hintText: 'Masukkan nomor HP Anda',
                        prefixIcon: const Icon(Icons.phone_android_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
