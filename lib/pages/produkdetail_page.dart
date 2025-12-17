import 'package:flutter/material.dart';

class MyProduk extends StatefulWidget {
  const MyProduk({super.key});

  @override
  State<MyProduk> createState() => _MyProdukState();
}

class _MyProdukState extends State<MyProduk> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 220,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/example.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}