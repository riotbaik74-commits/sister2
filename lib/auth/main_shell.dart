import 'package:flutter/material.dart';
import 'akun_screen.dart';
import 'cbt_screen.dart';
import 'home_screen.dart';
import 'lms_screen.dart';
import 'presensi_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;
  final _presensiMasuk = ValueNotifier<DateTime?>(null);

  @override
  void dispose() {
    _presensiMasuk.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      HomeScreen(
        presensiMasuk: _presensiMasuk,
        onOpenPresensi: () => setState(() => _index = 2),
      ),
      const LmsScreen(),
      PresensiScreen(presensiMasuk: _presensiMasuk),
      const CbtScreen(),
      const AkunScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'LMS',
          ),
          NavigationDestination(
            icon: Icon(Icons.radio_button_unchecked),
            selectedIcon: Icon(Icons.radio_button_checked),
            label: 'Presensi',
          ),
          NavigationDestination(
            icon: Icon(Icons.fact_check_outlined),
            selectedIcon: Icon(Icons.fact_check),
            label: 'CBT',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Akun',
          ),
        ],
      ),
    );
  }
}
