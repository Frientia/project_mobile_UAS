import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final user = FirebaseAuth.instance.currentUser;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String _countryCode = '+62';
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // ==================================================
  // LOAD PROFILE FROM SUPABASE (BY FIREBASE UID)
  // ==================================================
  Future<void> _loadProfile() async {
    final firebaseUid = user?.uid;
    if (firebaseUid == null) {
      setState(() => _loading = false);
      return;
    }

    try {
      final data = await Supabase.instance.client
          .from('users')
          .select()
          .eq('firebase_uid', firebaseUid)
          .maybeSingle();

      if (data != null) {
        _nameController.text = data['name'] ?? '';
        _emailController.text = data['email'] ?? '';

        final phone = data['phone'] ?? '';
        if (phone.isNotEmpty) {
          final match = RegExp(r'^(\+\d+)(.*)').firstMatch(phone);
          if (match != null) {
            _countryCode = match.group(1)!;
            _phoneController.text = match.group(2)!;
          }
        }
      }
    } catch (e) {
      debugPrint('Load profile error: $e');
    }

    setState(() => _loading = false);
  }

  // ==================================================
  // UPDATE PROFILE (UPDATE DATA LAMA)
  // ==================================================
  Future<void> _saveProfile() async {
    final firebaseUid = user?.uid;
    if (firebaseUid == null) return;

    setState(() => _loading = true);

    final phone = '$_countryCode${_phoneController.text.trim()}';

    try {
      // UPDATE SUPABASE (TANPA updated_at)
      await Supabase.instance.client
          .from('users')
          .update({'name': _nameController.text.trim(), 'phone': phone})
          .eq('firebase_uid', firebaseUid);

      // UPDATE SHARED PREFERENCES
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', _nameController.text.trim());

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profil berhasil diperbarui')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal menyimpan profil: $e')));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  // ==================================================
  // UI
  // ==================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3eaff),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Informasi Pribadi',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  _profileHeader(),
                  const SizedBox(height: 24),

                  _inputField('Nama', Icons.person, _nameController),

                  _inputField(
                    'Email',
                    Icons.email,
                    _emailController,
                    enabled: false,
                  ),

                  _phoneField(),

                  const SizedBox(height: 32),

                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _saveProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6F32CA),
                      ),
                      child: const Text(
                        'Simpan',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  // ==================================================
  // COMPONENTS
  // ==================================================
  Widget _profileHeader() {
    return Column(
      children: [
        const CircleAvatar(
          radius: 42,
          backgroundColor: Color(0xFF6F32CA),
          child: Icon(Icons.person, size: 42, color: Colors.white),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () {
            // upload foto (optional)
          },
          child: const Text(
            'Upload Foto Profil',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }

  Widget _phoneField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              showCountryPicker(
                context: context,
                showPhoneCode: true,
                onSelect: (country) {
                  setState(() {
                    _countryCode = '+${country.phoneCode}';
                  });
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade200,
              ),
              child: Text(_countryCode),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: 'Nomor HP',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputField(
    String label,
    IconData icon,
    TextEditingController controller, {
    bool enabled = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        enabled: enabled,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: enabled ? Colors.white : Colors.grey.shade200,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
