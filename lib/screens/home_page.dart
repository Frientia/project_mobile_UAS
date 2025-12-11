import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3eaff), // ungu pastel
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xfff3eaff),
        foregroundColor: Colors.black87,
        title: const Text(
          "MyConcert",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),

      drawer: const Drawer(child: Center(child: Text("Drawer"))),

      body: _selectedIndex == 0 ? _buildHomeUI() : _dummy(),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.grey,
        onTap: (i) => setState(() => _selectedIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }

  // ===============================================================
  //                >>> HALAMAN HOME UTAMA <<<
  // ===============================================================
  Widget _buildHomeUI() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =============================
          // SEARCH BAR + DROPDOWN LOKASI
          // =============================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                // Search Bar
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.search, color: Colors.grey),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "Cari di ...",
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // Lokasi
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.location_on,
                        color: Colors.redAccent,
                        size: 20,
                      ),
                      SizedBox(width: 6),
                      Text("Semua Lokasi", style: TextStyle(fontSize: 14)),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          // =============================
          // HERO BANNER
          // =============================
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: const DecorationImage(
                image: AssetImage(
                  "assets/images/example.png",
                ), // ganti gambar kamu
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // =============================
          // TITLE SECTION
          // =============================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: const [
                Expanded(
                  child: Text(
                    "Events of The Month",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 17),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // ======================================
          // EVENT CARD MODEL
          // ======================================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2, // *** DIUBAH: dari 1 kolom → 2 kolom ***
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.55,
              children: [
                _eventVerticalCard(
                  img: "assets/images/02.jpeg",
                  title: "Sorak Sorai Fest PART 2",
                  harga: "Rp51.170",
                  lokasi: "Kota Jakarta Timur",
                  tanggal: "31 Des - 02 Jan, 10:00 WIB",
                ),
                _eventVerticalCard(
                  img: "assets/images/02.jpeg",
                  title: "SHOW 2 | CINDERELLA",
                  harga: "Rp350.000",
                  lokasi: "Kota Jakarta Pusat",
                  tanggal: "Jumat, 16 Jan, 14:00 WIB",
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

  // ===============================================================
  //              CARD EVENT — MODEL VERTIKAL
  // ===============================================================
  Widget _eventVerticalCard({
    required String img,
    required String title,
    required String harga,
    required String lokasi,
    required String tanggal,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // GAMBAR EVENT
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
            child: Image.asset(
              img,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // LABEL "Tiket Tersedia"
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green[600],
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                "Tiket Tersedia",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),

          // Detail
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.redAccent, size: 18),
                    const SizedBox(width: 4),
                    Text(lokasi, style: const TextStyle(fontSize: 13)),
                  ],
                ),
                const SizedBox(height: 6),

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  tanggal,
                  style: const TextStyle(color: Colors.black87, fontSize: 13),
                ),

                const SizedBox(height: 8),

                Text(
                  harga,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  children: const [
                    Icon(Icons.event, size: 18, color: Colors.pink),
                    SizedBox(width: 6),
                    Text("Event", style: TextStyle(fontSize: 14)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dummy() {
    return const Center(
      child: Text("Halaman lain masih dummy", style: TextStyle(fontSize: 20)),
    );
  }
}
