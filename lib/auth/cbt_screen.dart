import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../core/widgets.dart';

class CbtScreen extends StatelessWidget {
  const CbtScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'CBT',
      subtitle: 'Computer Based Test',
      children: [
        const SectionHeader('Ujian Saya'),
        const AppCard(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Belum ada ujian aktif',
                    style:
                        TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                SizedBox(height: 8),
                Text('Ujian yang tersedia akan ditampilkan di sini.',
                    style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
              ],
            ),
          ),
        ),
        const SectionHeader('Riwayat Ujian'),
        const AppCard(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: SizedBox(
            width: double.infinity,
            child: Text('Belum ada riwayat ujian',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textMuted)),
          ),
        ),
      ],
    );
  }
}