import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile_uas/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_uas/pages/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool _isLoading = false;
  String? _error;
  bool _obscurePassword = true;

  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    );

    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animController,
        curve: Curves.easeOut,
      ),
    );

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }


  Future<void> _loginWithGoogle() async { 
    setState(() { 
      _isLoading = true; 
      _error = null; 
    });

    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        setState(() => _isLoading = false); 
        return;
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential( 
        accessToken: googleAuth.accessToken, 
        idToken: googleAuth.idToken, 
      );
      final userCredential = 
        await FirebaseAuth.instance.signInWithCredential(credential); 

      final user = userCredential.user; 
      final uid = user!.uid;
      final email = user.email!;
      
      final supabase = Supabase.instance.client;

      final existingUser = await supabase
        .from('users')
        .select('id, name')
        .eq('email', email)
        .maybeSingle();

      if (existingUser == null) {
        await supabase.from('users').upsert({
          'firebase_uid': uid,
          'email': user.email,
          'name': user.displayName ?? 'User',
        });
      }

      final data = await supabase 
        .from('users') 
        .select('name') 
        .eq('email', email)
        .single(); 
      
      final fullName = data['name'] ?? 'User';

      final prefs = await SharedPreferences.getInstance(); 
      await prefs.setBool('isLoggedIn', true); 
      await prefs.setString('uid', uid); 
      await prefs.setString('name', fullName);

      if (!mounted) return;

      showDialog( 
        context: context, 
        builder: (_) => AlertDialog( 
          title: const Text('Login Success'), 
          content: Text('Anda berhasil login\nSelamat datang, $fullName'), 
          actions: [ 
            TextButton( 
              onPressed: () { 
                Navigator.pop(context); 
                Navigator.pushReplacement( 
                  context, MaterialPageRoute(builder: (_) => HomePage()), 
                  ); 
                }, 
            child: const Text('OK'), 
            ), 
          ], 
        ), 
      );

    } on FirebaseAuthException catch (e) { 
      setState(() => _error = e.message); 
    } catch (e) { 
      setState(() => _error = e.toString()); 
    } finally { 
      setState(() => _isLoading = false); 
    }
  }

  Future<void> _logins() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailCtrl.text.trim(),
        password: passCtrl.text,
      );

      final user = credential.user;
      final uid = user!.uid;

      final supabase = Supabase.instance.client;
      final data = await supabase
          .from('users')
          .select('name')
          .eq('firebase_uid', uid)
          .maybeSingle();

      final fullName = data?['name'] ?? "User";

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('uid', uid);
      await prefs.setString('name', fullName);
      if (!mounted) return;

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Login Success'),
          content: Text('Anda berhasil login\nSelamat datang, $fullName'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _error = e.message;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3eaff),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            constraints: const BoxConstraints(maxWidth: 400),
            child: FadeTransition(
              opacity: _fadeAnim,
              child: SlideTransition(
                position: _slideAnim,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 60),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 113, 50, 202).withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.music_note_outlined,
                        size: 100,
                        color: const Color.fromARGB(255, 113, 50, 202),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Login to MyConcert',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 113, 50, 202),
                          ),
                    ),

                    SizedBox(height: 8),
                    Text(
                      'Silahkan login untuk melanjutkan',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.grey),
                    ),
                
                    SizedBox(height: 40),
                    TextField(
                      controller: emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade50,
                        labelText: 'Email',
                        hintText: 'Masukkan email Anda',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 113, 50, 202),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                
                    SizedBox(height: 20),
                
                    TextField(
                      controller: passCtrl,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade50,
                        labelText: 'Password',
                        hintText: 'Masukkan password Anda',
                        prefixIcon: Icon(Icons.password_outlined),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 113, 50, 202),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                
                    SizedBox(height: 20),
                    if (_error != null)
                      Text(_error!, style: const TextStyle(color: Colors.red)),
                    const SizedBox(height: 16),
                
                    AnimatedScale(
                      scale: _isLoading ? 0.97 : 1,
                      duration: const Duration(milliseconds: 150),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                          onPressed: _isLoading ? null : _logins,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 113, 50, 202),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text(
                                  'Login',
                                  style: TextStyle(fontSize: 16, color: Colors.white),
                                ),
                        ),
                      ),
                    ),
                
                    SizedBox(height: 20),
                
                    Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text("atau"),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                
                    SizedBox(height: 20),
                
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: _isLoading ? null : _loginWithGoogle,
                        icon: Image.asset(
                          'assets/images/google_logo.png',
                          height: 24,
                          width: 24,
                        ),
                        label: Text(
                          'Login dengan Google',
                          style: TextStyle(color: Colors.black87),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: Colors.white,
                          side: BorderSide(color: Colors.grey),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                
                
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Belum punya akun? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterPage(),
                              ),
                            );
                          },
                          child: Text(
                            "Daftar",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 113, 50, 202),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
