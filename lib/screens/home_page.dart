import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    Center(
      child: Text(
        "My Text",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 22),
      ),
    ),
    Center(
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
    Center(
      child: Text(
        "Ini halaman Settings",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      ),
    ),
  ];

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
          "Rismanita App",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
      ),

      // =========================
      // Drawer (Dibuat lebih clean)
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
                      backgroundImage: AssetImage("assets/loopy lembur.jpg"),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Rismanita Lestari",
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
      // Body (Mirip struktur SplashScreen1 → clean & center)
      // =========================
      body: SafeArea(child: _pages[_selectedIndex]),

      // =========================
      // Bottom Navigation Bar
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
