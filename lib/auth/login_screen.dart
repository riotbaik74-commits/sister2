import 'package:flutter/material.dart';
import '../core/routes.dart';
import '../core/theme.dart';
import '../core/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _nisCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _hide = true;

  @override
  void dispose() {
    _nisCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _login() {
    if (_nisCtrl.text.trim().isEmpty || _passCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('NIS dan password wajib diisi')),
      );
      return;
    }
    
    Navigator.of(context).pushReplacementNamed(AppRoutes.main);
  }

  @override
  Widget build(BuildContext context) {
    const label = TextStyle(
        fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.textDark);

    return Scaffold(
      body: Column(
        children: [
          const AppHeader(title: 'Masuk', subtitle: 'Selamat datang di ABSENKU'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const SizedBox(height: 8),
                Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 80,
                    errorBuilder: (context, error, stack) => const Icon(
                        Icons.school,
                        size: 80,
                        color: AppColors.primary),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Masuk ke akun siswa',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textDark)),
                const SizedBox(height: 8),
                const Text('Gunakan NIS yang terdaftar.',
                    style: TextStyle(color: AppColors.textMuted, fontSize: 13)),
                const SizedBox(height: 28),
                const Text('NIS', style: label),
                const SizedBox(height: 8),
                TextField(
                  controller: _nisCtrl,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                      hintText: 'Masukkan NIS'),
                ),
                const SizedBox(height: 20),
                const Text('Password', style: label),
                const SizedBox(height: 8),
                TextField(
                  controller: _passCtrl,
                  obscureText: _hide,
                  onSubmitted: (_) => _login(),
                  decoration: InputDecoration(
                    hintText: 'Masukkan password',
                    suffixIcon: IconButton(
                      icon: Icon(_hide ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => setState(() => _hide = !_hide),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Lupa password?',
                        style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700)),
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(onPressed: _login, child: const Text('MASUK')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}