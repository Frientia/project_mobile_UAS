import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({
    super.key,
    required this.ticketType,
    required this.day,
    required this.price,
  });

  final String ticketType;
  final String day;
  final String price;

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

class _PaymentPageState extends State<PaymentPage> {
  String? selectedPayment;

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
              children: const [
                Text('Total Pembayaran',
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
                SizedBox(height: 4),
                Text('Rp 500.000',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
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
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
