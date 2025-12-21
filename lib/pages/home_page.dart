import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;

  Product({required this.id, required this.name});
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("Home Page")));
  }
}
