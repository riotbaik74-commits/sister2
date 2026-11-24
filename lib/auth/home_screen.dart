import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../core/routes.dart';
import '../core/theme.dart';
import '../core/widgets.dart';
import '../models/data.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onOpenPresensi;
  final ValueListenable<DateTime?> presensiMasuk;

  const HomeScreen({
    super.key,
    required this.onOpenPresensi,
    required this.presensiMasuk,
  });

  void _go(BuildContext context, String routeName) =>
      Navigator.of(context).pushNamed(routeName);

  String _formatWaktu(DateTime waktu) =>
      '${waktu.hour.toString().padLeft(2, '0')}:'
      '${waktu.minute.toString().padLeft(2, '0')}:'
      '${waktu.second.toString().padLeft(2, '0')}';

  String _formatTanggal(DateTime waktu) =>
      '${waktu.day.toString().padLeft(2, '0')}/'
      '${waktu.month.toString().padLeft(2, '0')}/'
      '${waktu.year}';

  @override
  Widget build(BuildContext context) {
    final lesson = lessons.first;
    const muted = TextStyle(color: AppColors.textMuted, fontSize: 12);

    Widget stat(String value, String label) => Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 4),
          Text(label, style: muted),
        ],
      ),
    );

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              AppHeader(
                title: 'Hai, ${student.nama}',
                subtitle:
                    '${student.nis} | ${student.kelas} | SMK N 1 Bukateja',
              ),
              Positioned(
                right: 8,
                top: 0,
                child: SafeArea(
                  bottom: false,
                  child: IconButton(
                    icon: const Icon(
                      Icons.notifications_none,
                      color: Colors.white,
                    ),
                    onPressed: () => _go(context, AppRoutes.notifikasi),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ValueListenableBuilder<DateTime?>(
                  valueListenable: presensiMasuk,
                  builder: (context, waktuMasuk, _) => AppCard(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: [
                        stat(_formatTanggal(DateTime.now()), 'Tanggal'),
                        stat(
                          waktuMasuk == null
                              ? '--:--'
                              : _formatWaktu(waktuMasuk),
                          'Masuk',
                        ),
                        stat('--:--', 'Pulang'),
                      ],
                    ),
                  ),
                ),
                SectionHeader(
                  'Presensi',
                  onSeeAll: () => _go(context, AppRoutes.riwayat),
                ),
                ValueListenableBuilder<DateTime?>(
                  valueListenable: presensiMasuk,
                  builder: (context, waktuMasuk, _) => AppCard(
                    onTap: onOpenPresensi,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Presensi Masuk',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                waktuMasuk == null
                                    ? 'Belum melakukan presensi masuk'
                                    : '${_formatWaktu(waktuMasuk)} | ${_formatTanggal(waktuMasuk)}',
                                style: muted,
                              ),
                            ],
                          ),
                        ),
                        StatusChip(
                          label: waktuMasuk == null
                              ? 'Belum Presensi'
                              : 'Tercatat',
                          background: waktuMasuk == null
                              ? AppColors.primarySoft
                              : AppColors.successBg,
                          foreground: waktuMasuk == null
                              ? AppColors.primary
                              : AppColors.success,
                        ),
                      ],
                    ),
                  ),
                ),
                AppCard(
                  onTap: onOpenPresensi,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Presensi Pulang',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Belum melakukan presensi pulang',
                              style: muted,
                            ),
                          ],
                        ),
                      ),
                      const StatusChip(
                        label: 'Belum Presensi',
                        background: AppColors.primarySoft,
                        foreground: AppColors.primary,
                      ),
                    ],
                  ),
                ),
                SectionHeader(
                  'Jurnal PKL',
                  onSeeAll: () => _go(context, AppRoutes.jurnal),
                ),
                const EmptyCard(
                  title: 'Periode PKL belum dimulai',
                  message: 'Jurnal akan aktif saat periode PKL dimulai.',
                ),
                SectionHeader(
                  'Jadwal Pelajaran',
                  onSeeAll: () => _go(context, AppRoutes.jadwal),
                ),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lesson.mapel.toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('${lesson.waktu} | ${lesson.guru}', style: muted),
                    ],
                  ),
                ),
                SectionHeader(
                  'Perizinan',
                  onSeeAll: () => _go(context, AppRoutes.izin),
                ),
                AppCard(
                  onTap: () => _go(context, AppRoutes.izin),
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: const SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, color: AppColors.primary),
                            SizedBox(width: 6),
                            Text(
                              'Ajukan Izin',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w800,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text('Jika berhalangan hadir di sekolah', style: muted),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
