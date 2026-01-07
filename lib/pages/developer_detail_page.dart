import 'package:flutter/material.dart';

class DeveloperDetailPage extends StatelessWidget {
  final String name;
  final String nim;
  final String kelas;
  final String role;
  final String interest;
  final String description;

  const DeveloperDetailPage({
    super.key,
    required this.name,
    required this.nim,
    required this.kelas,
    required this.role,
    required this.interest,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Developer")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: const TextStyle(fontSize: 18)),
            Text(role),
            const SizedBox(height: 8),
            Text("NIM: $nim"),
            Text("Kelas: $kelas"),
            const SizedBox(height: 12),
            Text(interest),
            const SizedBox(height: 12),
            Text(description),
          ],
        ),
      ),
    );
  }
}
