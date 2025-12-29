import 'package:flutter/material.dart';

class MyRiwayat extends StatefulWidget {
  const MyRiwayat({super.key});

  @override
  State<MyRiwayat> createState() => _MyRiwayatState();
}

class _MyRiwayatState extends State<MyRiwayat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
            children: [],
        ),
      ),
    );
  }
}