import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../core/widgets.dart';

class NotifikasiScreen extends StatelessWidget {
  const NotifikasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const items = [
      ('Informasi Sekolah', 'Pengumuman sekolah akan muncul di sini.'),
      ('Informasi Presensi', 'Status presensi harian kamu.'),
      ('Informasi Pembelajaran', 'Pembaruan materi dan tugas LMS.'),
    ];

    return AppPage(
      title: 'Notifikasi',
      subtitle: 'Informasi terbaru dari sekolah',
      showBack: true,
      children: [
        const SectionHeader('Terbaru'),
        for (final (title, desc) in items)
          AppCard(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 16)),
                  const SizedBox(height: 8),
                  Text(desc,
                      style: const TextStyle(
                          color: AppColors.textMuted, fontSize: 12)),
                ],
              ),
            ),
          ),
      ],
    );
  }
}