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

  /// ===============================================================
  /// LOAD RIWAYAT PESANAN DARI SUPABASE (BY FIREBASE UID)
  /// ===============================================================
  Future<void> _loadRiwayat() async {
    try {
      final supabase = Supabase.instance.client;

      final response = await supabase
          .from('orders')
          .select()
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
          ? const Center(
              child: Text(
                "Belum ada riwayat pesanan",
                style: TextStyle(fontSize: 14),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
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
                      Text(
                        "Order ID: ${order['id']}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Total: Rp ${order['total_price']}",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 113, 50, 202),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
