import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';

class MyProfilDev extends StatefulWidget {
  const MyProfilDev({super.key});

  @override
  State<MyProfilDev> createState() => _MyProfilDevState();
}

class _MyProfilDevState extends State<MyProfilDev> 
    with SingleTickerProviderStateMixin {
  static const _primaryColor = Color(0xFF1E3A8A);

  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  final ScrollController _scrollController = ScrollController();
  final GlobalKey _roleKey = GlobalKey();

  bool _expanded = false; 

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fade = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );
    _controller.forward();

    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
              ScrollDirection.forward &&
          _expanded) {
        setState(() => _expanded = false);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text('Profil Developer'),
        centerTitle: true,
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: FadeTransition(
        opacity: _fade,
        child: SlideTransition(
          position: _slide,
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 36),
            child: Column(
              children: [
                _profileHeader(theme),
                SizedBox(height: 24),
                _infoCard(theme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _profileHeader(ThemeData theme) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                _primaryColor,
                _primaryColor.withValues(alpha: 0.55),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: _primaryColor.withValues(alpha: 0.35),
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 56,
            backgroundImage: AssetImage('assets/images/example.png'),
          ),
        ),
        SizedBox(height: 18),
        Text(
          'Muhamad Yajid Rizky',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 6),
        Text(
          'NIM 1123150114 • TI-SE 23 M',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _infoCard(ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 26,
            offset: Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(Icons.star_rounded, 'Minat & Keahlian'),
          SizedBox(height: 14),
          _chipList([
            'Flutter',
            'Firebase',
            'Supabase',
            'UI/UX',
            'REST API',
            'Git & GitHub',
          ]),
          SizedBox(height: 32),
          _expandableRole(theme),
          SizedBox(height: 32),
          _sectionTitle(Icons.link_rounded, 'Media Sosial'),
          SizedBox(height: 14),
          _socialLinks(),
        ],
      ),
    );
  }

  Widget _expandableRole(ThemeData theme) {
    return Column(
      key: _roleKey,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(Icons.work_outline_rounded, 'Peran Dalam Proyek'),
        SizedBox(height: 12),

        AnimatedSize(
          duration: Duration(milliseconds: 350),
          curve: Curves.easeInOut,
          child: Text(
            _expanded ? _fullRoleText : _shortRoleText,
            style: theme.textTheme.bodyMedium?.copyWith(height: 1.65),
            textAlign: TextAlign.justify,
          ),
        ),

        SizedBox(height: 12),

        GestureDetector(
          onTap: () {
            setState(() => _expanded = !_expanded);

            if (!_expanded) return;

            WidgetsBinding.instance.addPostFrameCallback((_) {
              final ctx = _roleKey.currentContext;
              if (ctx != null) {
                Scrollable.ensureVisible(
                  ctx,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOutCubic,
                );
              }
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _expanded ? 'Tutup' : 'Lihat selengkapnya',
                style: const TextStyle(
                  color: _primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 4),
              AnimatedRotation(
                turns: _expanded ? 0.5 : 0,
                duration: const Duration(milliseconds: 300),
                child: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: _primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _sectionTitle(IconData icon, String title) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: _primaryColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 20, color: _primaryColor),
        ),
        const SizedBox(width: 14),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }

  Widget _chipList(List<String> items) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: items.map((item) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: _primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            item,
            style: const TextStyle(
              color: _primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _socialLinks() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _socialButton(
        icon: Icons.facebook_rounded,
        color: const Color(0xFF1877F2),
        url: 'https://www.facebook.com/Frientia',
      ),
      _socialButton(
        icon: Icons.camera_alt_rounded,
        color: const Color(0xFFE1306C),
        url: 'https://instagram.com/frientia',
      ),
      _socialButton(
        icon: Icons.code_rounded,
        color: Colors.black,
        url: 'https://github.com/Frientia',
      ),
      _socialButton(
        icon: Icons.work_rounded,
        color: const Color(0xFF0A66C2),
        url: 'https://www.linkedin.com/in/muhamad-yajid-rizky-b5120433a',
      ),
    ],
  );
}

Widget _socialButton({
  required IconData icon,
  required Color color,
  required String url,
}) {
  return InkWell(
    borderRadius: BorderRadius.circular(16),
    onTap: () async {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    },
    child: Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(
        icon,
        color: color,
        size: 26,
      ),
    ),
  );
}

  static const _shortRoleText =
      'Berperan sebagai ketua kelompok serta bertanggung jawab dalam '
      'perancangan dan pengembangan fitur utama aplikasi.';

  static const _fullRoleText =
      'Berperan sebagai ketua kelompok dengan tanggung jawab memberikan arahan '
      'dan masukan teknis kepada anggota tim selama proses pengembangan. '
      'Selain itu, saya terlibat langsung dalam perancangan dan implementasi '
      'fitur-fitur utama aplikasi, seperti autentikasi pengguna (login, logout, '
      'Google Sign-In), pengelolaan data konser, detail konser, serta proses '
      'pembelian tiket.\n\n'
      'Saya juga bertanggung jawab dalam integrasi Firebase untuk otentikasi '
      'pengguna serta melakukan setup Supabase sebagai basis data backend. '
      'Di sisi antarmuka, saya memastikan desain UI/UX tetap konsisten, '
      'responsif, dan mudah digunakan. Selain pengembangan, saya turut '
      'mengawasi proses pengujian aplikasi untuk memastikan kualitas dan '
      'kestabilan sistem sebelum tahap peluncuran.';

}