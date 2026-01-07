import 'package:flutter/material.dart';

class DeveloperDetailPage extends StatelessWidget {
  final String name;
  final String nim;
  final String kelas;

  const DeveloperDetailPage({
    super.key,
    required this.name,
    required this.nim,
    required this.kelas,
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
            Text(nim),
            Text(kelas),
          ],
        ),
      ),
    );
  }
}
