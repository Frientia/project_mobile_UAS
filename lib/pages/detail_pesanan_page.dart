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

  /// ===============================================================
  /// LOAD DETAIL PESANAN + ORDER ITEMS + PRODUCTS (NAME)
  /// ===============================================================
  Future<void> _loadDetail() async {
    try {
      final supabase = Supabase.instance.client;

      final response = await supabase
          .from('orders')
          .select(
            'id,total_price,status,payment_method,created_at,'
            'order_items(ticket_type,quantity,subtotal,day,'
            'products(name))',
          )
          .eq('id', widget.orderId)
          .single();

      if (!mounted) return;

      setState(() {
        order = response;
        isLoading = false;
      });
    } catch (e) {
      debugPrint('ERROR LOAD DETAIL: $e');
      if (!mounted) return;
      setState(() => isLoading = false);
    }
  }

  /// ===============================================================
  /// FORMAT TANGGAL
  /// ===============================================================
  String _formatDate(String isoDate) {
    final date = DateTime.parse(isoDate);
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year} "
        "${date.hour.toString().padLeft(2, '0')}:"
        "${date.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3eaff),
      appBar: AppBar(
        title: const Text("Detail Pesanan"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : order == null
          ? const Center(child: Text("Data tidak ditemukan"))
          : _buildContent(),
    );
  }

  /// ===============================================================
  /// MAIN CONTENT
  /// ===============================================================
  Widget _buildContent() {
    final items = List<Map<String, dynamic>>.from(order!['order_items'] ?? []);

    final Map<String, dynamic>? product = items.isNotEmpty
        ? items.first['products']
        : null;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// NAMA EVENT (DARI PRODUCTS)
          Text(
            product?['name'] ?? 'Nama Event',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          /// INFORMASI PESANAN
          _card(
            title: "Informasi Pesanan",
            child: Column(
              children: [
                _row("Order ID", order!['id']),
                _row("Status", order!['status']),
                _row("Metode Pembayaran", order!['payment_method']),
                _row("Tanggal", _formatDate(order!['created_at'])),
              ],
            ),
          ),

          const SizedBox(height: 16),

          /// DETAIL TIKET
          _card(
            title: "Detail Tiket",
            child: Column(
              children: items.map((item) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${item['ticket_type']} - ${item['day']}",
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Qty ${item['quantity']}",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Rp ${item['subtotal']}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 16),

          /// TOTAL
          _card(
            title: "Total Pembayaran",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  "Rp ${order!['total_price']}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 113, 50, 202),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ===============================================================
  /// CARD WIDGET
  /// ===============================================================
  Widget _card({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
