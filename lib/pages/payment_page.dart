import 'package:flutter/material.dart';
import 'package:mobile_uas/screens/lottie_success.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({
    super.key,
    required this.productId,
    required this.ticketType,
    required this.day,
    required this.price,
    required this.firebaseUid,
  });

  final String productId;
  final String ticketType;
  final String day;
  final int price;
  final String firebaseUid;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentTile extends StatelessWidget {
  const _PaymentTile({
    required this.value,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String value;
  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      value: value,
      title: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(title),
        ],
      ),
      subtitle: Text(subtitle),
    );
  }
}

class _PaymentPageState extends State<PaymentPage> 
    with SingleTickerProviderStateMixin {
  String? selectedPayment;

  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  
  Future<void> _submitPayment() async {
    if (selectedPayment == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih metode pembayaran terlebih dahulu')),
      );
      return;
    }

    try {
      final supabase = Supabase.instance.client;

      final order = await supabase
          .from('orders')
          .insert({
            'firebase_uid': widget.firebaseUid,
            'total_price': widget.price,
            'payment_method': selectedPayment,
            'status': 'paid',
          })
          .select()
          .single();

      final orderId = order['id'];

      await supabase.from('order_items').insert({
        'order_id': orderId,
        'product_id': widget.productId,
        'ticket_type': widget.ticketType,
        'day': widget.day,
        'quantity': 1,
        'price_each': widget.price,
        'subtotal': widget.price,
      });

      if (!mounted) return;

     Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => MySuccess(
            order_id: orderId,
            firebaseUid: widget.firebaseUid,
          ),
        ),
      );

    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal menyimpan pembayaran: $e')));
    }
  }

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    );

    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animController,
        curve: Curves.easeOut,
      ),
    );

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Selesaikan Pembayaran',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionCard(
              title: 'Ringkasan Pesanan', 
              child: Column(
                children: [
                  _rowItem('Tiket', widget.ticketType),
                  _rowItem('Hari', widget.day),
                  _rowItem('Harga', 'Rp${widget.price}', bold: true),
                ]
              ),
            ),
            SizedBox(height: 26),
            _sectionCard(
              title: 'Metode Pembayaran',
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.info_outline,
                            size: 18, color: Colors.deepPurple),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Pembayaran hanya simulasi (tanpa validasi)',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                  RadioGroup<String>(
                    groupValue: selectedPayment,
                    onChanged: (value) {
                      setState(() {
                        selectedPayment = value;
                      });
                    },
                    child: Column(
                      children: const [
                        _PaymentTile(
                          value: 'Transfer Bank',
                          title: 'Transfer Bank',
                          subtitle: 'BCA, Mandiri, BRI',
                          icon: Icons.account_balance,
                        ),
                        _PaymentTile(
                          value: 'E-Wallet',
                          title: 'E-Wallet',
                          subtitle: 'OVO, GoPay, Dana',
                          icon: Icons.account_balance_wallet,
                        ),
                        _PaymentTile(
                          value: 'Virtual Account',
                          title: 'Virtual Account',
                          subtitle: 'VA Bank',
                          icon: Icons.credit_card,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),
            Text(
              'Yang dipilih: ${selectedPayment ?? "Belum memilih"}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.black12)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Total Pembayaran',
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 4),
                Text(
                  'Rp ${widget.price}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: _submitPayment,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 113, 50, 202),
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Bayar', style: TextStyle(fontSize: 16, color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
    Widget _sectionCard({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
  
    Widget _rowItem(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
