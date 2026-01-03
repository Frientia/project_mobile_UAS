import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_uas/pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

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

  // Controller
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController hpController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  // Register ke Firebase
  Future<void> registerUser({
    required String email,
    required String password,
    required String fullName,
    required String phone,
  }) async {
    final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final firebaseUid = cred.user!.uid;

    //Insert ke Supabase
    final supabase = Supabase.instance.client;

    await supabase.from('users').insert({
      'firebase_uid': firebaseUid,
      'name': fullName,
      'email': email,
      'phone': phone,
    });
  }

  Future<void> handleRegister() async {
    final email = emailController.text.trim();
    final password = passController.text.trim();
    final confirmPassword = confirmController.text.trim();
    final fullName = namaController.text.trim();
    final phone = hpController.text.trim();

    if (fullName.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Semua field harus diisi')));
      return;
    }
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password dan konfirmasi tidak sesuai')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await registerUser(
        email: email,
        password: password,
        fullName: fullName,
        phone: phone,
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Registrasi berhasil')));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal registrasi: $e')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    namaController.dispose();
    emailController.dispose();
    hpController.dispose();
    passController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth > 600;
          final iconSize = isTablet ? 120.0 : 80.0;

          return Center(
            child: SingleChildScrollView(
              child: Container(
                width: size.width * 0.9,
                padding: const EdgeInsets.all(20.0),
                child: FadeTransition(
                  opacity: _fadeAnim,
                  child: SlideTransition(
                    position: _slideAnim,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 113, 50, 202).withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.person_add_alt_1_outlined,
                            size: iconSize * 0.7,
                            color: const Color.fromARGB(255, 113, 50, 202),
                          ),
                        ),
                        const SizedBox(height: 20),
                    
                       Text(
                          "Register",
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 113, 50, 202),
                              ),
                        ),
                    
                        const SizedBox(height: 8),
                    
                        Text(
                          "Silakan isi data untuk membuat akun",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.grey),
                        ),
                    
                        const SizedBox(height: 20),
                    
                        // Nama Lengkap
                        TextField(
                          controller: namaController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade50,
                            labelText: 'Nama Lengkap',
                            hintText: 'Masukkan nama Anda',
                            prefixIcon: const Icon(Icons.person_outline),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                    
                        const SizedBox(height: 20),
                    
                        // Email
                        TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade50,
                            labelText: 'Email',
                            hintText: 'Masukkan Email Anda',
                            prefixIcon: const Icon(Icons.email_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                    
                        const SizedBox(height: 20),
                    
                        // No HP
                        TextField(
                          controller: hpController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade50,
                            labelText: 'No Handphone',
                            hintText: 'Masukkan nomor HP Anda',
                            prefixIcon: const Icon(Icons.phone_android_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                    
                        const SizedBox(height: 20),
                    
                        // Password
                        TextField(
                          controller: passController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade50,
                            labelText: 'Password',
                            hintText: 'Masukkan password',
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                    
                        const SizedBox(height: 20),
                    
                        // Konfirmasi Password
                        TextField(
                          controller: confirmController,
                          obscureText: _obscureConfirmPassword,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade50,
                            labelText: 'Konfirmasi Password',
                            hintText: 'Ulangi password Anda',
                            prefixIcon: const Icon(Icons.lock_reset_outlined),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureConfirmPassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword =
                                      !_obscureConfirmPassword;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                    
                        const SizedBox(height: 24),
                    
                        Align(
                          alignment: Alignment.centerRight,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Sudah Punya Akun? ',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: isTablet ? 16 : 14,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Login Sekarang',
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 113, 50, 202),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const LoginPage(),
                                        ),
                                      );
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                    
                        const SizedBox(height: 20),
                    
                        // Tombol Register
                        AnimatedScale(
                          scale: _isLoading ? 0.97 : 1,
                          duration: const Duration(milliseconds: 150),
                          child: SizedBox(
                              width: double.infinity,
                              height: isTablet ? 55 : 45,
                              child: ElevatedButton(
                              onPressed: _isLoading ? null : handleRegister,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  113,
                                  50,
                                  202,
                                ),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Text(
                                'Daftar',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: isTablet ? 18 : 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
