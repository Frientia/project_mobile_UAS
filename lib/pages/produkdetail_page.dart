import 'package:flutter/material.dart';

class MyProduk extends StatefulWidget {
  const MyProduk({super.key});

  @override
  State<MyProduk> createState() => _MyProdukState();
}

class _MyProdukState extends State<MyProduk> {
  String selectedTicket = 'Reguler';
  String selectedDays = 'Day 1';

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 220,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/example.png'),
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
                      'Sorak Sorai Festival',
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
                                children: const [
                                  Icon(Icons.location_on, size: 16),
                                  SizedBox(width: 4),
                                  Text('Jakarta, Indonesia'),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: const [
                                  Icon(Icons.access_time, size: 16),
                                  SizedBox(width: 4),
                                  Text('18:00 - 22:00 WIB'),
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
                                children: const [
                                  Icon(Icons.calendar_today, size: 16),
                                  SizedBox(width: 4),
                                  Text('30 Desember 2024'),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: const [
                                  Icon(Icons.music_note, size: 16),
                                  SizedBox(width: 4),
                                  Text('Music Concert'),
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
                      'Sorak Sorai Fest adalah festival musik yang menghadirkan berbagai musisi lokal dan nasional dengan pengalaman hiburan terbaik selama liburan akhir tahun.',
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
                          items: const [
                            DropdownMenuItem(
                              value: 'Reguler',
                              child: Text('Reguler - Rp54.581'),
                            ),
                            DropdownMenuItem(
                              value: 'VIP',
                              child: Text('VIP - Rp150.000'),
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
                          value: selectedDays,
                          icon: Icon(Icons.keyboard_arrow_down),
                          isExpanded: true,
                          items: const [
                            DropdownMenuItem(
                              value: 'Day 1',
                              child: Text('Day 1 - Konser Hari Pertama'),
                            ),
                            DropdownMenuItem(
                              value: 'Day 2',
                              child: Text('Day 2 - Konser Hari Kedua'),
                            ),
                          ],
                          onChanged: (value) {
                           setState(() {
                             selectedDays = value!;
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
                  "Mulai dari", 
                  style: TextStyle(fontSize: 12),
                ),
                Text(selectedTicket == 'Reguler' ? 'Rp54.581' : 'Rp150.000', 
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
              },
              child: Text(
                'Pesan Tiket',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}