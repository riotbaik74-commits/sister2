import 'package:flutter/material.dart';
import '../core/routes.dart';
import '../core/theme.dart';
import '../core/widgets.dart';
import '../models/data.dart';

class AkunScreen extends StatelessWidget {
  const AkunScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget row(String label, String value, {bool last = false}) => Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 4),
          decoration: BoxDecoration(
            border: last
                ? null
                : const Border(bottom: BorderSide(color: AppColors.border)),
          ),
          child: Row(
            children: [
              SizedBox(
                  width: 110,
                  child: Text(label,
                      style: const TextStyle(
                          color: AppColors.textMuted, fontSize: 12))),
              Expanded(
                  child: Text(value,
                      style: const TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 14))),
            ],
          ),
        );

    return AppPage(
      title: 'Akun Siswa',
      subtitle: 'Informasi profil dan pengaturan',
      children: [
        AppCard(
          color: AppColors.primarySoft,
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  const Icon(Icons.person, color: AppColors.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(student.nama.toUpperCase(),
                        style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w800,
                            fontSize: 17)),
                  ),
                ]),
                const SizedBox(height: 12),
                Text('${student.nis} | ${student.kelas}',
                    style: const TextStyle(fontSize: 13)),
              ],
            ),
          ),
        ),
        const SectionHeader('Informasi Akun'),
        row('Nama Lengkap', student.nama),
        row('NIS', student.nis),
        row('Kelas', student.kelas),
        row('Sekolah', student.sekolah, last: true),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: () {
            
          },
          child: const Text('PENGATURAN AKUN'),
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.login, (route) => false),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(54),
            side: const BorderSide(color: AppColors.border),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
          ),
          child: const Text('KELUAR',
              style: TextStyle(
                  color: AppColors.textDark, fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }
}