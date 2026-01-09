import 'package:flutter/material.dart';

class AgraProfile extends StatefulWidget {
  const AgraProfile({super.key});

  @override
  State<AgraProfile> createState() => _AgraProfileState();
}

class _AgraProfileState extends State<AgraProfile> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF0F2A44),
      body: Center(
        child: Text('Profile Page', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

Widget _buildTopProfile() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
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
    child: Row(
      children: [
        const CircleAvatar(
          radius: 36,
          backgroundImage: AssetImage('assets/profile.jpg'),
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
                '@Android Mobile Developer',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
