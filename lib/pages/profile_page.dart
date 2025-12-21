import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  String _countryCode = '+62';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Informasi Pribadi')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _profileHeader(), // ✅ PANGGIL DI SINI
            const SizedBox(height: 24),
            _inputField('Nama', Icons.person, _nameController),
            _inputField('Email', Icons.email, _emailController),
            _phoneField(),
            _inputField(
              'Password',
              Icons.lock,
              _passwordController,
              obscure: true,
            ),

            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                final phone = '$_countryCode${_phoneController.text}';
                debugPrint(phone);
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileHeader() {
    return Column(
      children: [
        const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () {
            // nanti bisa isi upload image
          },
          child: const Text('Upload Foto Profil'),
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
                border: Border.all(color: Colors.grey.shade300),
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
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Widget untuk input field
  Widget _inputField(
    String label,
    IconData icon,
    TextEditingController controller, {
    bool obscure = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
