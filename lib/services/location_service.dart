import 'dart:async';
import 'dart:math';

import 'package:location/location.dart' as loc;

import '../core/config.dart';

/// Hasil deteksi lokasi untuk presensi.
class LokasiPresensi {
  final double latitude;
  final double longitude;
  final double? akurasi;
  final bool lokasiPalsu;
  final double jarakKeSekolah;

  const LokasiPresensi({
    required this.latitude,
    required this.longitude,
    required this.akurasi,
    required this.lokasiPalsu,
    required this.jarakKeSekolah,
  });

  bool get dalamRadius => jarakKeSekolah <= SchoolConfig.radiusMeter;
}

class LocationException implements Exception {
  final String message;
  const LocationException(this.message);

  @override
  String toString() => message;
}

/// Pembungkus package `location`.
class LocationService {
  final loc.Location _location = loc.Location();

  /// Pastikan layanan GPS aktif (menampilkan dialog sistem di Android).
  Future<bool> pastikanGpsAktif() async {
    var aktif = await _location.serviceEnabled();
    if (!aktif) aktif = await _location.requestService();
    return aktif;
  }

  /// Ambil lokasi saat ini. Izin lokasi harus sudah diberikan sebelumnya.
  Future<LokasiPresensi> ambilLokasi() async {
    if (!await pastikanGpsAktif()) {
      throw const LocationException(
        'GPS tidak aktif. Aktifkan layanan lokasi lalu coba lagi.',
      );
    }

    await _location.changeSettings(accuracy: loc.LocationAccuracy.high);

    final loc.LocationData data;
    try {
      data = await _location.getLocation().timeout(const Duration(seconds: 20));
    } on TimeoutException {
      throw const LocationException(
        'Gagal mendapatkan lokasi (timeout). Coba di tempat terbuka.',
      );
    }
    final latitude = data.latitude;
    final longitude = data.longitude;

    return LokasiPresensi(
      latitude: latitude,
      longitude: longitude,
      akurasi: data.accuracy,
      lokasiPalsu: data.isMock ?? false,
      jarakKeSekolah: _jarakMeter(
        latitude,
        longitude,
        SchoolConfig.latitude,
        SchoolConfig.longitude,
      ),
    );
  }

  /// Jarak dua titik (rumus Haversine), dalam meter.
  static double _jarakMeter(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const r = 6371000.0;
    double rad(double d) => d * pi / 180;
    final dLat = rad(lat2 - lat1);
    final dLon = rad(lon2 - lon1);
    final a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(rad(lat1)) * cos(rad(lat2)) * sin(dLon / 2) * sin(dLon / 2);
    return 2 * r * atan2(sqrt(a), sqrt(1 - a));
  }
}
