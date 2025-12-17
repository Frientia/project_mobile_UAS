import 'package:flutter/material.dart';

class MyMenu extends StatelessWidget {
  const MyMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = constraints.maxWidth > 1100
              ? 1100
              : constraints.maxWidth;

          return Center(
            child: Container(
              width: maxWidth,
              padding: const EdgeInsets.all(24),
              child: ListView(
                children: const [
                  SizedBox(height: 24),
                  Center(
                    child: Text(
                      'Menu',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
