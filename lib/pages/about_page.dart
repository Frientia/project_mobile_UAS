import 'package:flutter/material.dart';

class MyAbout extends StatefulWidget {
  const MyAbout({super.key});

  @override
  State<MyAbout> createState() => _MyAboutState();
}

class _MyAboutState extends State<MyAbout> {
  static const Color primaryColor = Color.fromARGB(255, 113, 50, 202);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3eaff),
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: const Center(child: Text('About Page')),
    );
  }
}
