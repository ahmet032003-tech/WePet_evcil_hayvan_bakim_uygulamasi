import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Sıcak Amber & Karamel Paleti (Palet 3)
  static const Color primary = Color(0xFFD97706); // Sıcak Amber/Karamel
  static const Color primaryLight = Color(0xFFFEF3C7); // Açık Amber
  static const Color secondary = Color(0xFF059669); // Zümrüt Yeşili
  static const Color background = Color(0xFFFFFBEB); // Sıcak Vanilya / Krem
  static const Color cardSurface = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFFFF); // Geriye dönük uyumluluk
  static const Color textDark = Color(0xFF1E293B);
  static const Color textMuted = Color(0xFF94A3B8);
  static const Color badgePurple = Color(0xFF8B5CF6);
  static const Color badgeYellow = Color(0xFFF59E0B);

  // Aliaslar (Eski referansların sorunsuz çalışması için)
  static const Color accentPurple = badgePurple;
  static const Color accentYellow = badgeYellow;

  // Yardımcı Renkler & Gölge
  static const Color borderLight = Color(0xFFF1F5F9);
  static const Color shadowColor = Color(0x0A000000); // %4 siyah opaklık

  // Degrade (Alt Banner vb. için - Sıcak Amber tonları)
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFD97706), Color(0xFFF59E0B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Standart Yumuşak Gölge
  static List<BoxShadow> get softShadow => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ];
}
