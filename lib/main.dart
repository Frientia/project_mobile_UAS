import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_uas/pages/home_page.dart';
import 'package:mobile_uas/pages/menu_page.dart';
import 'package:mobile_uas/screens/splash_launch_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mobile_uas/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  runApp(const MyProject());
}

class MyProject extends StatelessWidget {
  const MyProject({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyConcert',
      debugShowCheckedModeBanner: false,
      home: MyLauncherScreen(),
      routes: {
        '/home': (_) => HomePage(),
        '/profile': (_) => MyMenu(),
      },
    );
  }
}
