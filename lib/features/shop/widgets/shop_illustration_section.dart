import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class ShopIllustrationSection extends StatelessWidget {
  const ShopIllustrationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 260,
        height: 260,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              AppColors.primary.withValues(alpha: 0.16),
              AppColors.primaryLight.withValues(alpha: 0.0),
            ],
            radius: 0.75,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Merkez 3D Mama Kabı Kartı
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(36),
                boxShadow: AppColors.softShadow,
              ),
              child: const Icon(
                Icons.ramen_dining_rounded,
                size: 74,
                color: AppColors.primary,
              ),
            ),
            // Sol Üst: Ödül Tasması İkonu
            Positioned(
              top: 28,
              left: 24,
              child: _FloatingBadgeIcon(
                icon: Icons.pets_rounded,
                backgroundColor: AppColors.accentPurple,
                size: 56,
              ),
            ),
            // Sağ Alt: Kedi Oyuncağı İkonu
            Positioned(
              bottom: 28,
              right: 24,
              child: _FloatingBadgeIcon(
                icon: Icons.attractions_rounded,
                backgroundColor: AppColors.accentYellow,
                size: 58,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FloatingBadgeIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final double size;

  const _FloatingBadgeIcon({
    required this.icon,
    required this.backgroundColor,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppColors.softShadow,
      ),
      child: Icon(
        icon,
        color: AppColors.surface,
        size: size * 0.52,
      ),
    );
  }
}
