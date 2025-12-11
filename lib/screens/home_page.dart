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
      backgroundColor: const Color(0xfff3eaff),
      appBar: AppBar(
        backgroundColor: const Color(0xfff3eaff),
        title: const Text("MyConcert"),
        elevation: 0,
      ),
      drawer: const Drawer(child: Center(child: Text("Drawer"))),

      body: _selectedIndex == 0 ? _buildHomeUI() : _dummy(),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
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

  Widget _buildHomeUI() {
    return SingleChildScrollView(
      child: Column(
        children: const [SizedBox(height: 20), Text("Home UI Placeholder")],
      ),
    );
  }

  Widget _dummy() {
    return const Center(child: Text("Halaman lain"));
  }
}
