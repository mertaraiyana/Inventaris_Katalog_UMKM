import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // State untuk menampung pesan error masing-masing field
  String? _emailError;
  String? _passwordError;

  String? get emailError => _emailError;
  String? get passwordError => _passwordError;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _emailError = null;
    _passwordError = null;
    notifyListeners();

    // Simulasi loading autentikasi demo
    await Future.delayed(const Duration(seconds: 1));

    _isLoading = false;

    // Akun demo yang valid
    const validEmail = 'admin@example.com';
    const validPassword = 'admin123';

    if (email == validEmail && password == validPassword) {
      notifyListeners();
      return true;
    }

    // Jika email salah
    if (email != validEmail) {
      _emailError = 'Email Anda salah!';
    }
    
    // Jika password salah
    if (password != validPassword) {
      _passwordError = 'Password Anda salah!';
    }

    notifyListeners();
    return false;
  }

  // Fungsi untuk membersihkan error saat mengetik ulang (opsional)
  void clearErrors() {
    _emailError = null;
    _passwordError = null;
    notifyListeners();
  }
}
