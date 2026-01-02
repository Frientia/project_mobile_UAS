import 'package:flutter/material.dart';

class MyDeveloper extends StatefulWidget {
  const MyDeveloper({super.key});

  @override
  State<MyDeveloper> createState() => _MyDeveloperState();
}

class _MyDeveloperState extends State<MyDeveloper> {
  static const Color primaryColor = Color.fromARGB(255, 113, 50, 202);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Developer'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _DeveloperCard(
              name: 'Agra Hafiz',
              role: 'Flutter Developer',
              image: 'assets/images/developer/people.png',
              isMain: true,
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: _DeveloperCard(
                    name: 'Developer 2',
                    role: 'Backend Developer',
                    image: 'assets/images/developer/people.png',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _DeveloperCard(
                    name: 'Developer 3',
                    role: 'UI / UX Designer',
                    image: 'assets/images/developer/people.png',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _DeveloperCard extends StatelessWidget {
  final String name;
  final String role;
  final String image;
  final bool isMain;

  const _DeveloperCard({
    required this.name,
    required this.role,
    required this.image,
    this.isMain = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset(image, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 12),

          Center(
            child: Text(
              name,
              style: TextStyle(
                fontSize: isMain ? 17 : 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 4),

          Center(
            child: Text(role, style: const TextStyle(color: Colors.grey)),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
