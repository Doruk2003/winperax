// FILE: lib/app/core/theme/colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // --- Common Colors ---
  static const Color primaryColor = Color(0xFF4FD2C5); // Yeşil
  static const Color secondaryColor = Color(0xFF6366F1); // Açık mor
  static const Color success = Color(0xFF10B981); // Yeşil (Online)
  static const Color gray = Color(0xFF94A3B8); // Gri (Offline)

  // --- Light Theme Colors ---
  static const Color backgroundLight = Color(0xFFFFFFFF); // Beyaz
  static const Color sidebarBgLight = Color(0xFFF8FAFC); // Sidebar arka planı
  static const Color sidebarSelectedLight = Color(0xFFE2E8F0); // Seçili item
  static const Color sidebarHoverLight = Color(0xFFF1F5F9); // Hover efekti
  static const Color textColorLight = Color(0xFF1E293B); // Koyu gri yazı
  static const Color iconColorLight = Color(0xFF64748B); // Orta gri ikon
  static const Color cardBorderLight = Color(0xFFE2E8F0); // Card kenarlığı

  // --- Dark Theme Colors ---
  static const Color backgroundDark = Color(0xFF1F2937); // Panel arka planı
  static const Color cardDark = Color(0xFF2D3748); // Cardlar
  static const Color sidebarDark = Color(0xFF111827); // Sidebar için daha koyu

  // --- Legacy / Constants Colors (eski app_colors.dart'ten) ---
  static const Color primary = Color(
    0xFF66BB6A,
  ); // Eski: yeşil tonu — gerekirse silinir
  static const Color secondary = Colors.grey;
  static const Color background = Color(0xFFF5F5F5);
  static const Color cardBackground = Colors.white;
  static const Color textPrimary = Colors.black;
  static const Color textSecondary = Colors.grey;

    // ✅ Tooltip renkleri
  static const Color tooltipDark = Color(0xFF2D3341);
  static const Color tooltipLight = Color(0xFFFFFFFF);
  static const Color borderDark = Color(0xFF4A5260);
  static const Color borderLight = Color(0xFFD0D5DD);

}
