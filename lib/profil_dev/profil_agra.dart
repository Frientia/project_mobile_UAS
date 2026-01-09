import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_uas/pages/developer_page.dart' show MyDeveloper;

class AgraProfile extends StatefulWidget {
  const AgraProfile({super.key});

  @override
  State<AgraProfile> createState() => _AgraProfileState();
}

class _AgraProfileState extends State<AgraProfile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F2A44),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildTopProfile(context),
            const SizedBox(height: 20),
            _buildSocialDrawerCard(),
            const SizedBox(height: 20),
            _buildAboutMe(),
            const SizedBox(height: 20),
            _buildSkills(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildTopProfile(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 44, 16, 28),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const MyDeveloper()),
                  );
                },
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          Row(
            children: [
              const CircleAvatar(
                radius: 36,
                backgroundImage: AssetImage(
                  'assets/images/developer/developer2/agra.jpeg',
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Agra Alfian Hafiz',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Android Mobile Developer',
                      style: TextStyle(fontSize: 13, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),
          _buildStats(),
        ],
      ),
    );
  }

  Widget _buildStats() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _StatItem(title: 'Total Project', value: '4'),
          _DividerVertical(),
          _StatItem(title: 'Kelas', value: 'TI SE 23 M'),
          _DividerVertical(),
          _StatItem(title: 'NIM', value: '1123150025'),
        ],
      ),
    );
  }

  Widget _buildSocialDrawerCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF173B5F),
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FaIcon(FontAwesomeIcons.instagram, color: Colors.pink),
          FaIcon(FontAwesomeIcons.facebook, color: Colors.blue),
          FaIcon(FontAwesomeIcons.github, color: Colors.white),
          FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green),
          FaIcon(FontAwesomeIcons.linkedin, color: Colors.lightBlueAccent),
        ],
      ),
    );
  }

  Widget _buildAboutMe() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF173B5F),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About Me',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),

          AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: const Text(
              'Android Mobile Developer enthusiast dengan fokus pada '
              'pengembangan aplikasi menggunakan Flutter dan Firebase. '
              'Berpengalaman dalam clean code dan arsitektur aplikasi yang rapi.',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white70,
                height: 1.6,
                fontSize: 13,
              ),
            ),

            secondChild: const Text(
              'Saya merupakan Android Mobile Developer enthusiast yang berfokus '
              'pada pengembangan aplikasi menggunakan Flutter dan Firebase. '
              'Saya mengutamakan clean code, arsitektur aplikasi yang terstruktur, '
              'serta integrasi backend yang modern dan scalable.\n\n'
              'Pada project ini, saya berperan dalam mendesain dan mengembangkan '
              'beberapa fitur utama, di antaranya Splash Screen, Register Page, '
              'Lottie Animation Screen sebelum masuk ke Home, Menu Page, '
              'serta Menu Profile yang mencakup logika upload foto profil, '
              'perubahan nama, dan perubahan nomor handphone. '
              'Selain itu, saya juga terlibat dalam pengembangan Developer Page, '
              'About Page, serta Profile Page pribadi.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Colors.white70,
                height: 1.6,
                fontSize: 13,
              ),
            ),
          ),

          const SizedBox(height: 6),

          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Text(
              _isExpanded ? 'Lihat Lebih Sedikit' : 'Lihat Selengkapnya',
              style: const TextStyle(
                color: Colors.lightBlueAccent,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkills() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF173B5F),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Skills',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),

          SkillBar(
            skill: 'Flutter',
            percent: 0.85,
            icon: Image.asset('assets/images/icons/flutter.png', width: 23),
          ),
          SkillBar(
            skill: 'Firebase',
            percent: 0.80,
            icon: Image.asset('assets/images/icons/firebase.png', width: 15),
          ),
          const SkillBar(
            skill: 'PHP',
            percent: 0.70,
            icon: FaIcon(FontAwesomeIcons.php, color: Colors.indigo, size: 20),
          ),
          const SkillBar(
            skill: 'JavaScript',
            percent: 0.65,
            icon: FaIcon(FontAwesomeIcons.js, color: Colors.yellow, size: 20),
          ),
          const SkillBar(
            skill: 'GitHub',
            percent: 0.75,
            icon: FaIcon(
              FontAwesomeIcons.github,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String title;
  final String value;

  const _StatItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(fontSize: 12, color: Colors.white70),
        ),
      ],
    );
  }
}

class _DividerVertical extends StatelessWidget {
  const _DividerVertical();

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 28, color: Colors.white24);
  }
}

class SkillBar extends StatelessWidget {
  final String skill;
  final double percent;
  final Widget icon;

  const SkillBar({
    super.key,
    required this.skill,
    required this.percent,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              icon,
              const SizedBox(width: 8),
              Text(
                '$skill (${(percent * 100).toInt()}%)',
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: percent,
            backgroundColor: Colors.white24,
            valueColor: const AlwaysStoppedAnimation(Colors.lightBlueAccent),
            minHeight: 8,
          ),
        ],
      ),
    );
  }
}
