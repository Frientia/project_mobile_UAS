import 'package:flutter/material.dart';

class DetailPesananPage extends StatelessWidget {
  final String orderId;

  const DetailPesananPage({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Pesanan")),
      body: Center(child: Text("Detail Pesanan ID: $orderId")),
    );
  }
}
