import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../core/widgets.dart';

class JurnalScreen extends StatelessWidget {
  const JurnalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Jurnal PKL',
      subtitle: 'Catatan kegiatan praktik kerja lapangan',
      showBack: true,
      children: const [
        AppCard(
          color: AppColors.primarySoft,
          padding: EdgeInsets.all(20),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('STATUS PERIODE PKL',
                    style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                        fontSize: 12)),
                SizedBox(height: 12),
                Text('Periode PKL belum dimulai',
                    style:
                        TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
              ],
            ),
          ),
        ),
        SectionHeader('Jurnal Kegiatan'),
        EmptyCard(
          title: 'Belum ada jurnal yang dapat diisi',
          message:
              'Fitur jurnal akan aktif otomatis setelah periode PKL dimulai oleh sekolah.',
        ),
      ],
    );
  }
}