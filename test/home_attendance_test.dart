import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:o/auth/home_screen.dart';

void main() {
  testWidgets('Home updates when an attendance time is recorded', (
    tester,
  ) async {
    final presensiMasuk = ValueNotifier<DateTime?>(null);

    await tester.pumpWidget(
      MaterialApp(
        home: HomeScreen(onOpenPresensi: () {}, presensiMasuk: presensiMasuk),
      ),
    );

    expect(find.text('Belum melakukan presensi masuk'), findsOneWidget);

    presensiMasuk.value = DateTime(2026, 11, 24, 10, 5, 9);
    await tester.pump();

    expect(find.text('10:05:09 | 24/11/2026'), findsOneWidget);
    expect(find.text('Tercatat'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    presensiMasuk.dispose();
  });
}
