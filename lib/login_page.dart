import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: Text(
          'Selamat datang di aplikasi!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
