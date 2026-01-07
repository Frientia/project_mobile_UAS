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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Developer")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(radius: 60, backgroundImage: AssetImage(image)),
            const SizedBox(height: 16),
            Text(name, style: const TextStyle(fontSize: 18)),
            Text(role),
          ],
        ),
      ),
    );
  }
}
