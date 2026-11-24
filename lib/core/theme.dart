import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF087F8C);
  static const primarySoft = Color(0xFFE3F4F4);
  static const background = Color(0xFFF7F7F9);
  static const border = Color(0xFFE5E7EB);
  static const textDark = Color(0xFF2B2A2E);
  static const textMuted = Color(0xFF7A7A83);
  static const successBg = Color(0xFFD9F5E6);
  static const success = Color(0xFF1E8E5A);
}

ThemeData buildTheme() {
  final radius = BorderRadius.circular(12);
  OutlineInputBorder border(Color c) =>
      OutlineInputBorder(borderRadius: radius, borderSide: BorderSide(color: c));

  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
    scaffoldBackgroundColor: AppColors.background,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      hintStyle: const TextStyle(color: AppColors.textMuted),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      border: border(AppColors.border),
      enabledBorder: border(AppColors.border),
      focusedBorder: border(AppColors.primary),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        minimumSize: const Size.fromHeight(54),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,
      indicatorColor: Colors.transparent,
      labelTextStyle: WidgetStateProperty.resolveWith((s) => TextStyle(
            fontSize: 12,
            fontWeight: s.contains(WidgetState.selected)
                ? FontWeight.w700
                : FontWeight.w400,
            color: s.contains(WidgetState.selected)
                ? AppColors.primary
                : AppColors.textMuted,
          )),
    ),
  );
}