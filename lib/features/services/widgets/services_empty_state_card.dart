import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class ServicesEmptyStateCard extends StatelessWidget {
  const ServicesEmptyStateCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppColors.softShadow,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Sol Alan: Başlık ve Açıklama
          Expanded(
            flex: 6,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hizmet Geçmişin ve Planların Burada!',
                  style: AppTextStyles.heading1.copyWith(fontSize: 22),
                ),
                const SizedBox(height: 12),
                Text(
                  'Dostun için planladığın yürüyüşleri, evde bakım '
                  'randevularını ve geçmiş hizmet detaylarını bu '
                  'ekrandan kolayca takip edebilirsin.',
                  style: AppTextStyles.bodyMuted.copyWith(fontSize: 13.5),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Sağ Alan: Kedi / Köpek İllüstrasyon Alanı
          Expanded(
            flex: 4,
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    Icons.pets_rounded,
                    size: 64,
                    color: AppColors.primary,
                  ),
                  Positioned(
                    bottom: 14,
                    right: 14,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.accentYellow,
                        shape: BoxShape.circle,
                        boxShadow: AppColors.softShadow,
                      ),
                      child: const Icon(
                        Icons.cruelty_free_rounded,
                        size: 20,
                        color: AppColors.surface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

