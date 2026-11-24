import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../core/widgets.dart';
import '../models/data.dart';

class JadwalScreen extends StatelessWidget {
  const JadwalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Jadwal Pelajaran',
      subtitle: 'Jadwal kegiatan belajar siswa',
      showBack: true,
      children: [
        const AppCard(
          color: AppColors.primarySoft,
          child: SizedBox(
            width: double.infinity,
            child: Text('JUMAT · 06 NOVEMBER 2026',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.primary, fontWeight: FontWeight.w800)),
          ),
        ),
        for (final l in lessons)
          AppCard(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 110,
                  child: Text(l.waktu,
                      style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w800,
                          fontSize: 13)),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l.mapel,
                          style: const TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 16)),
                      const SizedBox(height: 8),
                      Text(l.guru == 'Ismawati, S.Pd' ? l.guru : 'Guru Pengampu',
                          style: const TextStyle(
                              color: AppColors.textMuted, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}