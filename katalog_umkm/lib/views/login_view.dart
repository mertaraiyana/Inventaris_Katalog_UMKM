import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/login_viewmodel.dart';
import 'main_menu_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Fungsi instan untuk memunculkan SnackBar pemberitahuan info akun demo
  void _showDemoCredentialSnackBar() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Tutup snackbar lama jika ada
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Info Akun Demo: admin@example.com / admin123'),
        backgroundColor: Colors.deepPurple,
        duration: Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Mengaktifkan listen: true agar UI merespon perubahan string error dari ViewModel
    final loginVM = Provider.of<LoginViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Katalog UMKM'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email', 
                  border: const OutlineInputBorder(),
                  // Menampilkan errorText dinamis dari ViewModel jika ada
                  errorText: loginVM.emailError,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email wajib diisi!';
                  }
                  if (!value.contains('@')) {
                    return 'Format email salah!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password', 
                  border: const OutlineInputBorder(),
                  // Menampilkan errorText dinamis dari ViewModel jika ada
                  errorText: loginVM.passwordError,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password wajib diisi!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              loginVM.isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      onPressed: () async {
                        // 1. Cek validasi form bawaan (apakah kosong / salah format)
                        if (!_formKey.currentState!.validate()) {
                          _showDemoCredentialSnackBar();
                          return;
                        }

                        // 2. Jika form terisi, cek keabsahan data ke ViewModel
                        bool success = await loginVM.login(
                          _emailController.text, 
                          _passwordController.text,
                        );
                        
                        if (!context.mounted) return;

                        if (success) {
                          Navigator.pushReplacement(
                            context, 
                            MaterialPageRoute(builder: (_) => const MainMenuView()),
                          );
                        } else {
                          // Jika data tidak sesuai, picu SnackBar pengingat akun demo
                          _showDemoCredentialSnackBar();
                        }
                      },
                      child: const Text('Masuk'),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
