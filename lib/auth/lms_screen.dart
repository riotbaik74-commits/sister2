import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../core/widgets.dart';

class LmsScreen extends StatelessWidget {
  const LmsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const items = [
      (Icons.view_headline, 'Materi Pembelajaran', 'Baca materi dari guru'),
      (Icons.check, 'Tugas Saya', 'Daftar tugas dan tenggat'),
      (Icons.arrow_upward, 'Pengumpulan Tugas', 'Kirim hasil pekerjaan'),
      (Icons.check_box_outline_blank, 'Aktivitas Kelas',
          'Informasi kegiatan belajar'),
    ];

    return AppPage(
      title: 'LMS Siswa',
      subtitle: 'Materi dan aktivitas pembelajaran',
      children: [
        const SectionHeader('Kelas Saya'),
        for (final (icon, title, desc) in items)
          AppCard(
            onTap: () {
            
            },
            child: Row(
              children: [
                SizedBox(
                    width: 56,
                    child: Icon(icon, color: AppColors.primary, size: 28)),
                Expanded(
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
              ],
            ),
          ),
      ],
    );
  }
}