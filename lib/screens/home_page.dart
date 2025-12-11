import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // =============================
  // PAGES (Home, Profile, Settings)
  // =============================
  final List<Widget> _pages = [
    // =========================
    // HOME PAGE + HERO BANNER
    // =========================
    ListView(
      padding: const EdgeInsets.all(0),
      children: [
        // ===== HERO BANNER =====
        Container(
          margin: const EdgeInsets.all(16),
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: const DecorationImage(
              image: AssetImage(
                "assets/images/hindia.png",
              ), // ganti asset kamu
              fit: BoxFit.cover,
            ),
          ),
        ),

        const SizedBox(height: 12),

        // ===== SECTION TITLE =====
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Events of The Month",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),

        const SizedBox(height: 20),
      ],
    ),

    // =========================
    // PROFILE PAGE
    // =========================
    const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Nama : Aditya Aji", style: TextStyle(fontSize: 20)),
          Text("NIM : 1123150058", style: TextStyle(fontSize: 20)),
          Text("Prodi : Teknik Informatika", style: TextStyle(fontSize: 20)),
        ],
      ),
    ),

    // =========================
    // SETTINGS PAGE
    // =========================
    const Center(
      child: Text(
        "Ini halaman Settings",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      ),
    ),
  ];

  // UNTUK PINDAH HALAMAN
  void _navigateToPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: const Text(
          "MyConcert",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
      ),

      // =========================
      // DRAWER
      // =========================
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.pinkAccent, Colors.pink],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage("assets/images/hindia.png"),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "My Concert",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "1123150058@global.ac.id",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),

              ListTile(
                leading: Icon(Icons.home, color: Colors.pink),
                title: Text("Home"),
                onTap: () {
                  _navigateToPage(0);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.person, color: Colors.pink),
                title: Text("Profile"),
                onTap: () {
                  _navigateToPage(1);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.pink),
                title: Text("Settings"),
                onTap: () {
                  _navigateToPage(2);
                  Navigator.pop(context);
                },
              ),

              const Spacer(),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.pinkAccent),
                title: Text("Logout"),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Kamu telah logout"),
                      backgroundColor: Colors.pinkAccent,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),

      // =========================
      // BODY
      // =========================
      body: SafeArea(child: _pages[_selectedIndex]),

      // =========================
      // BOTTOM NAVIGATION
      // =========================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.grey,
        onTap: _navigateToPage,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),

      // FAB BUTTON
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pinkAccent,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Tombol tambah ditekan"),
              backgroundColor: Colors.pinkAccent,
            ),
          );
        },
      ),
    );
  }
}
