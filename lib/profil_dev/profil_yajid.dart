import 'package:flutter/material.dart';

class MyProfilDev extends StatefulWidget {
  const MyProfilDev({super.key});

  @override
  State<MyProfilDev> createState() => _MyProfilDevState();
}

class _MyProfilDevState extends State<MyProfilDev> 
    with SingleTickerProviderStateMixin {

  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Developer'),
        centerTitle: true,
      ),
      body: Center(
        child: FadeTransition(
          opacity: _fade,
          child: SlideTransition(
            position: _slide,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}