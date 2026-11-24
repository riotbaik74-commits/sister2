import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../core/widgets.dart';
import '../models/data.dart';

class IzinScreen extends StatefulWidget {
  const IzinScreen({super.key});

  @override
  State<IzinScreen> createState() => _IzinScreenState();
}

class _IzinScreenState extends State<IzinScreen> {
  static const _jenis = ['Sakit', 'Izin', 'Keperluan keluarga'];

  final _ketCtrl = TextEditingController();
  final List<LeaveRequest> _riwayat = [];
  DateTime? _tanggal;
  String? _jenisDipilih;

  @override
  void dispose() {
    _ketCtrl.dispose();
    super.dispose();
  }

  String _fmt(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  Future<void> _pilihTanggal() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _tanggal ?? now,
      firstDate: now.subtract(const Duration(days: 7)),
      lastDate: now.add(const Duration(days: 90)),
    );
    if (picked != null) setState(() => _tanggal = picked);
  }

  void _kirim() {
    if (_tanggal == null ||
        _jenisDipilih == null ||
        _ketCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lengkapi semua data pengajuan')));
      return;
    }
    
    setState(() {
      _riwayat.insert(
          0, LeaveRequest(_tanggal!, _jenisDipilih!, _ketCtrl.text.trim()));
      _tanggal = null;
      _jenisDipilih = null;
      _ketCtrl.clear();
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Pengajuan terkirim')));
  }

  @override
  Widget build(BuildContext context) {
    const label = TextStyle(
        fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.textDark);

    return AppPage(
      title: 'Perizinan',
      subtitle: 'Pengajuan dan riwayat izin',
      showBack: true,
      children: [
        const SectionHeader('Ajukan Izin'),
        const Text('Tanggal izin', style: label),
        const SizedBox(height: 8),
        InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: _pilihTanggal,
          child: InputDecorator(
            decoration: const InputDecoration(),
            child: Text(
              _tanggal == null ? 'Pilih tanggal' : _fmt(_tanggal!),
              style: TextStyle(
                  color: _tanggal == null
                      ? AppColors.textMuted
                      : AppColors.textDark),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text('Jenis izin', style: label),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _jenisDipilih,
          hint: const Text('Sakit / Izin / Keperluan keluarga',
              style: TextStyle(color: AppColors.textMuted)),
          decoration: const InputDecoration(),
          items: [
            for (final j in _jenis) DropdownMenuItem(value: j, child: Text(j))
          ],
          onChanged: (v) => setState(() => _jenisDipilih = v),
        ),
        const SizedBox(height: 16),
        const Text('Keterangan', style: label),
        const SizedBox(height: 8),
        TextField(
          controller: _ketCtrl,
          maxLines: 3,
          decoration: const InputDecoration(hintText: 'Tuliskan alasan izin'),
        ),
        const SizedBox(height: 24),
        ElevatedButton(onPressed: _kirim, child: const Text('KIRIM PENGAJUAN')),
        const SectionHeader('Riwayat Pengajuan'),
        if (_riwayat.isEmpty)
          const AppCard(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Pengajuan izin',
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                  SizedBox(height: 8),
                  Text('Belum ada pengajuan terbaru',
                      style:
                          TextStyle(color: AppColors.textMuted, fontSize: 12)),
                ],
              ),
            ),
          )
        else
          for (final r in _riwayat)
            AppCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${r.jenis} · ${_fmt(r.tanggal)}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 15)),
                        const SizedBox(height: 6),
                        Text(r.keterangan,
                            style: const TextStyle(
                                color: AppColors.textMuted, fontSize: 12)),
                      ],
                    ),
                  ),
                  const StatusChip(
                      label: 'Menunggu',
                      background: AppColors.primarySoft,
                      foreground: AppColors.primary),
                ],
              ),
            ),
      ],
    );
  }
}