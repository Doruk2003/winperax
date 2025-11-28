import 'package:flutter/material.dart';

class AppTheme {
  // ------- DIMENSIONS -------
  static const double appBarHeight = 80; // ✅ Panel yüksekliği artık sabit bir değerden geliyor

  // ------- COLORS -------
  static const Color primaryColor = Color(0xFF4F46E5);
  static const Color secondaryColor = Color(0xFF6366F1);
  static const Color backgroundLight = Color(0xFFF9FAFB);
  static const Color backgroundDark = Color(0xFF1F2937); // Yeni: Daha açık bir gri
  static const Color cardDark = Color(0xFF2D3748); // Yeni: Card rengi
  static const Color surfaceDark = Color(0xFF1A202C); // Yeni: Drawer, Sidebar rengi

  // ------- LIGHT THEME -------
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
      ),

      scaffoldBackgroundColor: backgroundLight,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
        centerTitle: true,
        toolbarHeight: appBarHeight, // ✅ Theme'den yükseklik al
      ),

      textTheme: const TextTheme(
        headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(fontSize: 16),
        bodyMedium: TextStyle(fontSize: 14),
      ),

      cardTheme: const CardThemeData(
        elevation: 0,
        margin: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  // ------- DARK THEME -------
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.dark,
      ),

      // Yeni: Daha açık bir arka plan rengi
      scaffoldBackgroundColor: backgroundDark,

      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: appBarHeight, // ✅ Theme'den yükseklik al
      ),

      textTheme: const TextTheme(
        headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(fontSize: 16),
        bodyMedium: TextStyle(fontSize: 14),
      ),

      // Yeni: Daha açık bir card rengi
      cardTheme: CardThemeData(
        elevation: 0,
        margin: const EdgeInsets.all(8),
        color: cardDark, // Eski: Colors.grey.shade900
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey.shade800,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: secondaryColor,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
