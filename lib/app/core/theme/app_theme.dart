import 'package:flutter/material.dart';
import 'package:winperax/app/core/constants/app_colors.dart'; // ✅ Relative path ile import

ThemeData lightTheme() {
  return ThemeData(
    useMaterial3: false,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      titleTextStyle: TextStyle(color: Colors.white),
    ),
    cardTheme: CardThemeData(
      // ✅ CardThemeData kullanıldı
      color: AppColors.cardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
}

ThemeData darkTheme() {
  return ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.black87,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      titleTextStyle: TextStyle(color: Colors.white),
    ),
    cardTheme: CardThemeData(
      // ✅ CardThemeData kullanıldı
      color: AppColors.cardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
}
