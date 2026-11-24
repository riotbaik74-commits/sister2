import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<PermissionStatus> ensure(Permission permission) async {
    final status = await permission.status;
    if (status.isGranted || status.isLimited) return status;
    if (status.isPermanentlyDenied) return status;
    return permission.request();
  }

  static bool isOk(PermissionStatus status) =>
      status.isGranted || status.isLimited;

  static Future<void> showOpenSettingsDialog(
    BuildContext context,
    String namaIzin,
  ) {
    return showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Izin $namaIzin diperlukan'),
        content: Text(
          'Izin $namaIzin ditolak. Aktifkan izin tersebut di Pengaturan aplikasi agar presensi dapat dilakukan.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              openAppSettings();
              Navigator.of(ctx).pop();
            },
            child: const Text('Buka Pengaturan'),
          ),
        ],
      ),
    );
  }
}
