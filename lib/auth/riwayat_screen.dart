import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../core/widgets.dart';
import '../models/data.dart';

class RiwayatScreen extends StatelessWidget {
  const RiwayatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Riwayat Presensi',
      subtitle: 'Pantau catatan kehadiran',
      showBack: true,
      children: [
        const SectionHeader('November 2026'),
        for (final r in attendanceHistory)
          AppCard(
            child: Row(
              children: [
                SizedBox(
                  width: 56,
                  child: Text(r.tanggal,
                      style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w800,
                          fontSize: 24)),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(r.hari,
                          style: const TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 16)),
                      const SizedBox(height: 6),
                      Text('Jam masuk: ${r.jamMasuk ?? '—'}',
                          style: const TextStyle(
                              color: AppColors.textMuted, fontSize: 12)),
                    ],
                  ),
                ),
                Text(r.status,
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: r.status == 'Hadir'
                            ? AppColors.success
                            : AppColors.primary)),
              ],
            ),
          ),
      ],
    );
  }
}