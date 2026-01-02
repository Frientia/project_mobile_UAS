import 'package:flutter/material.dart';

class MyDeveloper extends StatefulWidget {
  const MyDeveloper({super.key});

  @override
  State<MyDeveloper> createState() => _MyDeveloperState();
}

class _MyDeveloperState extends State<MyDeveloper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Developer')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _DeveloperCard(name: 'Agra Hafiz'),
            const SizedBox(height: 20),
            Row(
              children: const [
                Expanded(child: _DeveloperCard(name: 'Developer 2')),
                SizedBox(width: 16),
                Expanded(child: _DeveloperCard(name: 'Developer 3')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
