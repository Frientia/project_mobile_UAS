import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DetailPesananPage extends StatefulWidget {
  final String orderId;

  const DetailPesananPage({super.key, required this.orderId});

  @override
  State<DetailPesananPage> createState() => _DetailPesananPageState();
}

class _DetailPesananPageState extends State<DetailPesananPage> {
  bool isLoading = true;
  Map<String, dynamic>? order;

  @override
  void initState() {
    super.initState();
    _loadDetail();
  }

  Future<void> _loadDetail() async {
    final supabase = Supabase.instance.client;

    final response = await supabase
        .from('orders')
        .select()
        .eq('id', widget.orderId)
        .single();

    setState(() {
      order = response;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Pesanan")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(child: Text("Total: Rp ${order!['total_price']}")),
    );
  }
}
