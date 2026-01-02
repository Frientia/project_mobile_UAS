import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyRiwayat extends StatefulWidget {
  final String firebaseUid;

  const MyRiwayat({super.key, required this.firebaseUid});

  @override
  State<MyRiwayat> createState() => _MyRiwayatState();
}

class _MyRiwayatState extends State<MyRiwayat> {
  bool isLoading = true;
  List<Map<String, dynamic>> orders = [];

  @override
  void initState() {
    super.initState();
    _loadRiwayat();
  }

  Future<void> _loadRiwayat() async {
    try {
      final supabase = Supabase.instance.client;

      final response = await supabase
          .from('orders')
          .select(
            'id,total_price,status,payment_method,created_at,'
            'order_items(ticket_type,quantity,subtotal,day)',
          )
          .eq('firebase_uid', widget.firebaseUid)
          .order('created_at', ascending: false);

      if (!mounted) return;

      setState(() {
        orders = List<Map<String, dynamic>>.from(response);
        isLoading = false;
      });
    } catch (e) {
      debugPrint('ERROR LOAD RIWAYAT: $e');
      if (!mounted) return;
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3eaff),
      appBar: AppBar(
        title: const Text("Riwayat Pesanan"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : orders.isEmpty
          ? const Center(child: Text("Belum ada riwayat pesanan"))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                final items = List<Map<String, dynamic>>.from(
                  order['order_items'] ?? [],
                );

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// HEADER
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Order #${order['id']}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          _statusBadge(order['status']),
                        ],
                      ),

                      const Divider(height: 24),

                      ...items.map((item) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${item['ticket_type']} - ${item['day']} (x${item['quantity']})",
                              ),
                              Text(
                                "Rp ${item['subtotal']}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),

                      const Divider(height: 24),

                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Total: Rp ${order['total_price']}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 113, 50, 202),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  /// ===============================================================
  /// STATUS BADGE
  /// ===============================================================
  Widget _statusBadge(String status) {
    Color color;
    String text;

    switch (status.toLowerCase()) {
      case 'paid':
        color = Colors.green;
        text = 'PAID';
        break;
      case 'pending':
        color = Colors.orange;
        text = 'PENDING';
        break;
      default:
        color = Colors.grey;
        text = status.toUpperCase();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}
