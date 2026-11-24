import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import '../core/config.dart';
import '../core/routes.dart';
import '../core/theme.dart';
import '../core/widgets.dart';
import '../services/location_service.dart';
import '../services/permission_service.dart';

class PresensiScreen extends StatefulWidget {
  final ValueNotifier<DateTime?> presensiMasuk;

  const PresensiScreen({super.key, required this.presensiMasuk});

  @override
  State<PresensiScreen> createState() => _PresensiScreenState();
}

class _PresensiScreenState extends State<PresensiScreen> {
  final _locationService = LocationService();
  bool _loading = false;
  LokasiPresensi? _lokasi;
  String? _error;

  String _formatWaktu(DateTime waktu) =>
      '${waktu.hour.toString().padLeft(2, '0')}:'
      '${waktu.minute.toString().padLeft(2, '0')}:'
      '${waktu.second.toString().padLeft(2, '0')}';

  void _snack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<bool> _izin(Permission permission, String nama) async {
    final status = await PermissionService.ensure(permission);
    if (PermissionService.isOk(status)) return true;
    if (!mounted) return false;
    if (status.isPermanentlyDenied || status.isRestricted) {
      await PermissionService.showOpenSettingsDialog(context, nama);
    } else {
      _snack('Izin $nama diperlukan untuk presensi');
    }
    return false;
  }

  Future<void> _mulaiPresensi() async {
    if (_loading) return;
    setState(() {
      _loading = true;
      _error = null;
      _lokasi = null;
    });
    try {
      if (!await _izin(Permission.camera, 'kamera')) return;
      if (!await _izin(Permission.locationWhenInUse, 'lokasi')) return;

      final lokasi = await _locationService.ambilLokasi();
      if (!mounted) return;
      setState(() => _lokasi = lokasi);

      if (lokasi.lokasiPalsu) {
        setState(
          () => _error =
              'Terdeteksi lokasi palsu (mock location). Matikan aplikasi lokasi palsu.',
        );
        return;
      }
      if (!lokasi.dalamRadius) {
        setState(
          () => _error =
              'Anda berada di luar area sekolah (${lokasi.jarakKeSekolah.toStringAsFixed(0)} m dari sekolah, maks ${SchoolConfig.radiusMeter.toStringAsFixed(0)} m).',
        );
        return;
      }

      widget.presensiMasuk.value = DateTime.now();
      _snack('Presensi masuk berhasil dicatat');
    } on LocationException catch (e) {
      if (mounted) setState(() => _error = e.message);
    } on PlatformException catch (e) {
      if (mounted) {
        setState(
          () => _error = 'Gagal mengakses kamera atau lokasi: ${e.message}',
        );
      }
    } on Exception catch (e) {
      if (mounted) setState(() => _error = 'Terjadi kesalahan: $e');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Widget _lokasiCard() {
    final lokasi = _lokasi;
    final ok =
        lokasi != null &&
        lokasi.dalamRadius &&
        !lokasi.lokasiPalsu &&
        _error == null;
    return AppCard(
      color: _error != null ? const Color(0xFFFDECEC) : AppColors.primarySoft,
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  ok ? Icons.check_circle : Icons.location_on,
                  size: 18,
                  color: _error != null ? Colors.red : AppColors.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  _error != null
                      ? 'Lokasi bermasalah'
                      : ok
                      ? 'Lokasi valid'
                      : 'Lokasi',
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ],
            ),
            if (_error != null) ...[
              const SizedBox(height: 8),
              Text(_error!, style: const TextStyle(fontSize: 13)),
            ],
            if (lokasi != null) ...[
              const SizedBox(height: 8),
              Text(
                'Koordinat: ${lokasi.latitude.toStringAsFixed(6)}, ${lokasi.longitude.toStringAsFixed(6)}',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textMuted,
                ),
              ),
              Text(
                'Jarak ke sekolah: ${lokasi.jarakKeSekolah.toStringAsFixed(0)} m'
                '${lokasi.akurasi != null ? ' · akurasi ±${lokasi.akurasi!.toStringAsFixed(0)} m' : ''}',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Presensi',
      subtitle: 'Presensi masuk dan pulang',
      children: [
        ValueListenableBuilder<DateTime?>(
          valueListenable: widget.presensiMasuk,
          builder: (context, waktuMasuk, _) => AppCard(
            color: AppColors.primarySoft,
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'STATUS KEHADIRAN HARI INI',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    waktuMasuk == null
                        ? 'Belum melakukan presensi masuk'
                        : 'Presensi masuk tercatat · ${_formatWaktu(waktuMasuk)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SectionHeader('Verifikasi Wajah'),
        Center(
          child: Container(
            width: 300,
            height: 340,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: AppColors.border),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.radio_button_unchecked,
                  size: 64,
                  color: AppColors.primary,
                ),
                SizedBox(height: 16),
                Text(
                  'Posisikan wajah di dalam bingkai',
                  style: TextStyle(color: AppColors.textMuted, fontSize: 13),
                ),
              ],
            ),
          ),
        ),
        if (_lokasi != null || _error != null) ...[
          const SizedBox(height: 16),
          _lokasiCard(),
        ],
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _loading ? null : _mulaiPresensi,
          child: _loading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('MULAI PRESENSI'),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () => Navigator.of(context).pushNamed(AppRoutes.riwayat),
          child: const Text(
            'Lihat riwayat presensi',
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: RichText(
            text: const TextSpan(
              style: TextStyle(color: AppColors.textMuted, fontSize: 12),
              children: [
                TextSpan(
                  text: 'Catatan: ',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                TextSpan(
                  text:
                      'izin kamera & lokasi serta deteksi lokasi sudah aktif. Tampilan kamera dan verifikasi wajah perlu dihubungkan ke sistem sekolah.',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
