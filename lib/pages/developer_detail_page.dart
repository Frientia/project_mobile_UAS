import 'package:flutter/material.dart';

class DeveloperDetailPage extends StatelessWidget {
  const DeveloperDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Developer")),
      body: const Center(child: Text("Developer Detail Page")),
    );
  }
}
