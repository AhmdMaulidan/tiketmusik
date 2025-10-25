import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiketmusik/main_page.dart';
import 'package:tiketmusik/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // In-memory user store (for simulation purposes)
  final List<Map<String, String>> _users = [];

  void _login() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;

      // Find user in the list
      final user = _users.firstWhere(
        (user) => user['email'] == email && user['password'] == password,
        orElse: () => {},
      );

      if (user.isNotEmpty) {
        // Navigate to main page with user's name
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(userName: user['name']),
          ),
        );
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email atau kata sandi salah.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _navigateToRegisterPage() async {
    final newUser = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterPage()),
    );

    if (newUser != null && newUser is Map<String, String>) {
      setState(() {
        _users.add(newUser);
        _emailController.text = newUser['email']!; // Pre-fill email
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registrasi berhasil! Silakan masuk.'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'TIKETMUSIK',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF8A2BE2),
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Masuk untuk melanjutkan',
                  style: GoogleFonts.poppins(
                    color: Colors.white70,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 50),
                TextFormField(
                  controller: _emailController,
                  style: GoogleFonts.poppins(color: Colors.white),
                  decoration: _buildInputDecoration('Email', Icons.email_outlined),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Silakan masukkan email Anda';
                    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Silakan masukkan email yang valid';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  style: GoogleFonts.poppins(color: Colors.white),
                  decoration: _buildInputDecoration('Kata Sandi', Icons.lock_outline),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Silakan masukkan kata sandi Anda';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8A2BE2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Masuk',
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: _navigateToRegisterPage,
                  child: Text(
                    'Belum punya akun? Daftar',
                    style: GoogleFonts.poppins(color: Colors.white70),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: GoogleFonts.poppins(color: Colors.white70),
      prefixIcon: Icon(icon, color: Colors.white70),
      filled: true,
      fillColor: Colors.grey.withOpacity(0.1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Color(0xFF8A2BE2), width: 2),
      ),
    );
  }
}
