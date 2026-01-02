import 'package:flutter/material.dart';

class DetailPesananPage extends StatefulWidget {
  final String orderId;

  const DetailPesananPage({super.key, required this.orderId});

  @override
  State<DetailPesananPage> createState() => _DetailPesananPageState();
}

class _DetailPesananPageState extends State<DetailPesananPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() => isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Pesanan")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(child: Text("Order ID: ${widget.orderId}")),
    );
  }
}
