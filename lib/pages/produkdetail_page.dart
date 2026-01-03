import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_uas/pages/payment_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyProduk extends StatefulWidget {
  const MyProduk({
    super.key,
    required this.productId,
    required this.firebaseUid,
    });
    final String productId;
    final String firebaseUid;

  @override
  State<MyProduk> createState() => _MyProdukState();
}

class _MyProdukState extends State<MyProduk> 
    with SingleTickerProviderStateMixin {
  
  final supabase = Supabase.instance.client;
  String? firebaseUid;


  Map<String, dynamic>? product;
  String selectedTicket = 'Reguler';
  String? selectedDay;

  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

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
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animController,
        curve: Curves.easeOut,
      ),
    );

    _animController.forward();

    _loadSession();
    fetchProduct();
  }

  Future<void> _loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      firebaseUid = prefs.getString('uid');
    });
  }


  Future<void> fetchProduct() async {
    final data = await supabase
        .from('products')
        .select()
        .eq('id', widget.productId)
        .single();

    setState(() {
      product = data;
      selectedDay = (product!['available_days'] as List).first;
    });
  }

   int get selectedPrice {
    if (selectedTicket == 'VIP') {
      return product!['price_vip'];
    }
    return product!['price_regular'];
  }
  
  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (product == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 220,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(product!['image_url']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product!['name'],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(Icons.location_on, size: 16),
                                      SizedBox(width: 4),
                                      Text(product!['location']),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(Icons.access_time, size: 16),
                                      SizedBox(width: 4),
                                      Text(product!['event_time']),
                                    ],
                                  ),
                                ),
                              ],
                            ),
            
                            const SizedBox(height: 16),
            
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(Icons.calendar_today, size: 16),
                                      SizedBox(width: 4),
                                      Text(product!['event_date']),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(Icons.music_note, size: 16),
                                      SizedBox(width: 4),
                                      Text(product!['category']),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
            
                        SizedBox(height: 16),
                        Divider(),
            
                        Text(
                          'Deskripsi Event',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          product!['description'],
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 24),
            
                        Text(
                          'Pilih Tiket',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
            
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedTicket,
                              isExpanded: true,
                              items: [
                                DropdownMenuItem(
                                  value: 'Reguler',
                                  child: Text(
                                    'Reguler - Rp${product!['price_regular']}',
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'VIP',
                                  child: Text(
                                    'VIP - Rp${product!['price_vip']}',
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                               setState(() {
                                 selectedTicket = value!;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        
                        Text(
                          'Pilih Hari',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
            
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedDay,
                              icon: Icon(Icons.keyboard_arrow_down),
                              isExpanded: true,
                              items: (product!['available_days'] as List)
                                  .map<DropdownMenuItem<String>>((day) {
                                return DropdownMenuItem<String>(
                                  value: day,
                                  child: Text(day),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedDay = value!;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Total Harga", 
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  'Rp $selectedPrice', 
                  style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 113, 50, 202),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
              final firebaseUser = FirebaseAuth.instance.currentUser;

              if (firebaseUser == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Silakan login terlebih dahulu')),
                );
                return;
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PaymentPage(
                    productId: product!['id'],
                    ticketType: selectedTicket,
                    day: selectedDay!,
                    price: selectedPrice, 
                    firebaseUid: firebaseUser.uid,
                  ),
                ),
              );
            },
              child: Text(
                'Beli Tiket',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}