import 'package:flutter/material.dart';
import 'package:mobile_uas/screens/splash_screen2.dart';
import 'package:mobile_uas/screens/splash_screen3.dart';

class splash_screen2 extends StatelessWidget {
  const splash_screen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage("assets/images/02.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
