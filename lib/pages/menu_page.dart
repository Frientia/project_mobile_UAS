import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile_uas/pages/about_page.dart';
import 'package:mobile_uas/pages/developer_page.dart';
import 'package:mobile_uas/pages/home_page.dart';
import 'package:mobile_uas/pages/login_page.dart';
import 'package:mobile_uas/pages/profile_page.dart';
import 'package:mobile_uas/pages/riwayat_pesanan.dart';
import 'package:mobile_uas/widgets/main_bottom_nav.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MyMenu extends StatefulWidget {
  const MyMenu({super.key});

  static const Color primaryColor = Color.fromARGB(255, 113, 50, 202);

  @override
  State<MyMenu> createState() => _MyMenuState();
}

class _MyMenuState extends State<MyMenu> {
  String _name = 'User';
  String? _avatarUrl;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      final data = await Supabase.instance.client
          .from('users')
          .select('name, avatar_url')
          .eq('firebase_uid', user.uid)
          .maybeSingle();

      if (!mounted) return;

      if (data != null) {
        setState(() {
          _name = data['name'] ?? 'User';
          _avatarUrl = data['avatar_url'];
        });
      }
    } catch (e) {
      debugPrint('Load menu profile error: $e');
    }
  }

  Future<void> _openInstagram() async {
    final Uri url = Uri.parse('https://www.instagram.com/konsertangerangraya/');

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Tidak bisa membuka Instagram';
    }
  }

  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();

      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      if (!context.mounted) return;

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Logout Success'),
          content: const Text('Anda berhasil Logout'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false,
                );
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Logout gagal: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3eaff),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double maxWidth = constraints.maxWidth > 1100
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
                  _sectionTitle('Aktivitas Saya'),
                  _menuItem(
                    Icons.trending_up,
                    'Riwayat Pembelian',
                    onTap: () {
                      final uid = FirebaseAuth.instance.currentUser?.uid;

                      if (uid == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('User belum login')),
                        );
                        return;
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MyRiwayat(firebaseUid: uid),
                        ),
                      );
                    },
                  ),
                  _menuItem(
                    Icons.groups,
                    'Komunitas Saya',
                    onTap: _openInstagram,
                  ),
                  _menuItem(
                    Icons.dashboard,
                    'Dashboard',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const HomePage()),
                      );
                    },
                  ),
                  const SizedBox(height: 32),
                  _sectionTitle('Pengaturan'),
                  _menuItem(
                    Icons.settings,
                    'Setting',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const MyProfile()),
                      );
                    },
                  ),
                  _menuItem(
                    Icons.code,
                    'Developer',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const MyDeveloper()),
                      );
                    },
                  ),
                  _menuItem(
                    Icons.info_outline,
                    'About',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const MyAbout()),
                      );
                    },
                  ),
                  const SizedBox(height: 32),
                  _logoutButton(context),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: MainBottomNav(currentIndex: 1, context: context),
    );
  }

  Widget _profileCard() {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MyProfile()),
        ).then((_) => _loadProfile());
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: _cardDecoration(),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: MyMenu.primaryColor,
              backgroundImage: _avatarUrl != null
                  ? NetworkImage(_avatarUrl!)
                  : null,
              child: _avatarUrl == null
                  ? const Icon(Icons.person, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text('Personal', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
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

  Widget _menuItem(IconData icon, String title, {VoidCallback? onTap}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      leading: Icon(icon, color: MyMenu.primaryColor),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  Widget _logoutButton(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.logout, color: Colors.red),
      title: const Text(
        'Logout',
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      tileColor: Colors.red.withValues(alpha: 0.05),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onTap: () => _logout(context),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10),
      ],
    );
  }
}
