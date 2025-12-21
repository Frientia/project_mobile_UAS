import 'package:flutter/material.dart';
import 'package:mobile_uas/screens/splash_screen2.dart';

class SplashScreen1 extends StatelessWidget {
  const SplashScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 40, bottom: 20),
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
                      image: AssetImage("assets/images/myconcert.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  "Welcome to MyConcert",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "     Dapatkan Pengalaman terbaik\nuntuk mencari tiket konser favoritmu",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255,113,50,202,),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 196, 123, 228),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFedede9),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Container(
                    margin: const EdgeInsets.only(left: 40, right: 40),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SplashScreen2(),
                          ),
                        );
                      },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255,113,50,202,),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 70),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
