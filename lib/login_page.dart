import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 60),
                Icon(Icons.lock_outline, size: 100, color: Colors.purple),
                SizedBox(height: 20),
                Text(
                  'Login to MyConcert',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Silahkan Login untuk melanjutkan',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
