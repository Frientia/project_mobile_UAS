import 'package:flutter/material.dart';

class DeveloperDetailPage extends StatelessWidget {
  final String name;
  final String nim;
  final String kelas;
  final String role;
  final String interest;
  final String description;
  final String image;

  const DeveloperDetailPage({
    super.key,
    required this.name,
    required this.nim,
    required this.kelas,
    required this.role,
    required this.interest,
    required this.description,
    required this.image,
  });

  /// 🎨 WARNA ALA INSTAGRAM
  static const Color igBackground = Color(0xffFAFAFA);
  static const Color igGrey = Color(0xff8E8E8E);
  static const Color igBlue = Color(0xff0095F6);
  static const Color igBorder = Color(0xffDBDBDB);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: igBackground,
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Developer",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// ================= HEADER PROFILE =================
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Row(
                children: [
                  /// FOTO PROFIL
                  ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.asset(
                      image,
                      height: 90,
                      width: 90,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(width: 20),

                  /// STAT ALA INSTAGRAM
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        _ProfileStat(title: "Project", value: "4"),
                        _ProfileStat(title: "Role", value: "UI/UX"),
                        _ProfileStat(title: "Skill", value: "Design"),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// ================= BIO + FOLLOW =================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    role,
                    style: const TextStyle(fontSize: 13, color: igGrey),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    interest,
                    style: const TextStyle(fontSize: 13, height: 1.4),
                  ),
                  const SizedBox(height: 12),

                  /// FOLLOW BUTTON (DUMMY)
                  SizedBox(
                    width: double.infinity,
                    height: 36,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: igBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Follow",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            /// ================= INFO MAHASISWA =================
            _infoCard(
              title: "Informasi Mahasiswa",
              child: Column(
                children: [
                  _row("Nama Lengkap", name),
                  _row("NIM", nim),
                  _row("Kelas", kelas),
                ],
              ),
            ),

            const SizedBox(height: 10),

            /// ================= TENTANG SAYA =================
            _infoCard(
              title: "Tentang Saya",
              child: Text(
                description,
                style: const TextStyle(fontSize: 14, height: 1.6),
                textAlign: TextAlign.justify,
              ),
            ),

            const SizedBox(height: 10),

            /// ================= KONTRIBUSI =================
            _infoCard(
              title: "Kontribusi dalam Aplikasi",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("• Splash Screen"),
                  SizedBox(height: 4),
                  Text("• Halaman Home"),
                  SizedBox(height: 4),
                  Text("• Riwayat Pesanan"),
                  SizedBox(height: 4),
                  Text("• Developer Detail Page"),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  /// ================= COMPONENT =================

  Widget _infoCard({required String title, required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: igBorder),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: igGrey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

/// ================= PROFILE STAT =================
class _ProfileStat extends StatelessWidget {
  final String title;
  final String value;

  const _ProfileStat({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(fontSize: 12, color: Color(0xff8E8E8E)),
        ),
      ],
    );
  }
}
