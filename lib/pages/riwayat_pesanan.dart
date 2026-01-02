import 'package:flutter/material.dart';

class MyRiwayat extends StatelessWidget {
  final String firebaseUid;

  const MyRiwayat({super.key, required this.firebaseUid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Riwayat Pesanan")),
      body: const Center(child: Text("Riwayat Pesanan")),
    );
  }
}
