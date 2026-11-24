import 'package:flutter/material.dart';
import 'core/routes.dart';
import 'core/theme.dart';
import 'auth/izin_screen.dart';
import 'auth/jadwal_screen.dart';
import 'auth/jurnal_screen.dart';
import 'auth/login_screen.dart';
import 'auth/main_shell.dart';
import 'auth/notifikasi_screen.dart';
import 'auth/riwayat_screen.dart';

void main() => runApp(const AbsenkuApp());

class AbsenkuApp extends StatelessWidget {
  const AbsenkuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ABSENKU',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (_) => const LoginScreen(),
        AppRoutes.main: (_) => const MainShell(),
        AppRoutes.riwayat: (_) => const RiwayatScreen(),
        AppRoutes.jadwal: (_) => const JadwalScreen(),
        AppRoutes.izin: (_) => const IzinScreen(),
        AppRoutes.jurnal: (_) => const JurnalScreen(),
        AppRoutes.notifikasi: (_) => const NotifikasiScreen(),
      },
    );
  }
}