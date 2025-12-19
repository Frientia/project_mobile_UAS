import 'package:flutter/material.dart';

class MyMenu extends StatelessWidget {
  const MyMenu({super.key});

  static const Color primaryColor = Color.fromARGB(255, 113, 50, 202);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = constraints.maxWidth > 1100
              ? 1100
              : constraints.maxWidth;

          return Center(
            child: Container(
              width: maxWidth,
              padding: const EdgeInsets.all(24),
              child: ListView(
                children: [
                  const SizedBox(height: 24),

                  const Center(
                    child: Text(
                      'Menu',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  _profileCard(),

                  const SizedBox(height: 32),

                  _sectionTitle('Pusat Bantuan'),
                  _menuItem(Icons.settings, 'Pengaturan Akun'),
                  _menuItem(Icons.code, 'Developer'),
                  _menuItem(Icons.info_outline, 'About'),

                  const SizedBox(height: 32),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ===================== PROFILE =====================
  Widget _profileCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(),
      child: Row(
        children: const [
          CircleAvatar(
            radius: 28,
            backgroundColor: primaryColor,
            child: Icon(Icons.person, color: Colors.white),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Agra Alfian Hafiz',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text('Personal', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _menuItem(IconData icon, String title, {String? badge}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      leading: Icon(icon, color: primaryColor),
      title: Text(title),
      trailing: badge != null
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                badge!,
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            )
          : const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [BoxShadow(color: Colors.black, blurRadius: 10)],
    );
  }
}
