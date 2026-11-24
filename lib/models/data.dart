class Student {
  final String nama, nis, kelas, sekolah;
  const Student(this.nama, this.nis, this.kelas, this.sekolah);
}

class Lesson {
  final String waktu, mapel, guru;
  const Lesson(this.waktu, this.mapel, this.guru);
}

class AttendanceRecord {
  final String tanggal, hari, status;
  final String? jamMasuk;
  const AttendanceRecord(this.tanggal, this.hari, this.jamMasuk, this.status);
}

class LeaveRequest {
  final DateTime tanggal;
  final String jenis, keterangan;
  const LeaveRequest(this.tanggal, this.jenis, this.keterangan);
}

const student = Student(
    'Fadhilah Ibnu Sina', '9226', 'XI RPL 1', 'SMK Negeri 1 Bukateja');

const lessons = <Lesson>[
  Lesson('08.00–08.40', 'Pendidikan Pancasila', 'Ismawati, S.Pd'),
  Lesson('08.40–09.20', 'Bahasa Indonesia', 'Guru Pengampu'),
  Lesson('09.20–10.00', 'Pemrograman Web', 'Guru Pengampu'),
  Lesson('10.15–11.00', 'Basis Data', 'Guru Pengampu'),
  Lesson('11.00–11.40', 'Projek Kreatif', 'Guru Pengampu'),
];

const attendanceHistory = <AttendanceRecord>[
  AttendanceRecord('06', 'Jumat', '06.35', 'Hadir'),
  AttendanceRecord('05', 'Kamis', '06.42', 'Hadir'),
  AttendanceRecord('04', 'Rabu', null, 'Izin'),
  AttendanceRecord('03', 'Selasa', '06.30', 'Hadir'),
  AttendanceRecord('02', 'Senin', '06.38', 'Hadir'),
];