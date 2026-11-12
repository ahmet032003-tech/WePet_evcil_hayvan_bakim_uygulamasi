import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../models/reservation_model.dart';

class ReservationCard extends StatelessWidget {
  final ReservationModel reservation;
  final VoidCallback? onCancel;
  final VoidCallback? onComplete;

  const ReservationCard({
    super.key,
    required this.reservation,
    this.onCancel,
    this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = reservation.status == ReservationStatus.active;
    final dateStr =
        '${reservation.date.day} ${_getMonth(reservation.date.month)} ${reservation.date.year}';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  reservation.serviceIcon,
                  color: AppColors.primary,
                  size: 26,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reservation.serviceTitle,
                      style: AppTextStyles.cardTitle.copyWith(fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$dateStr • ${reservation.timeSlot}',
                      style: AppTextStyles.bodyMuted.copyWith(
                        color: AppColors.textDark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        const Icon(
                          Icons.sell_outlined,
                          size: 13,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            reservation.effectiveOption,
                            style: AppTextStyles.bodyMuted.copyWith(
                              fontSize: 12,
                              color: AppColors.textDark,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isActive ? AppColors.secondary.withValues(alpha: 0.12) : AppColors.borderLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      isActive ? 'Aktif' : 'Tamamlandı',
                      style: AppTextStyles.badgeText.copyWith(
                        color: isActive ? AppColors.secondary : AppColors.textMuted,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '₺${reservation.price.toStringAsFixed(0)}',
                    style: AppTextStyles.heading2.copyWith(color: AppColors.primary, fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
          if (isActive) ...[
            const SizedBox(height: 12),
            const Divider(color: AppColors.borderLight, height: 1),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onCancel,
                  child: const Text('İptal Et', style: TextStyle(color: Colors.redAccent, fontSize: 12)),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: onComplete,
                  child: const Text('Tamamlandı İşaretle', style: TextStyle(color: AppColors.secondary, fontSize: 12)),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  String _getMonth(int m) {
    const months = ['', 'Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran', 'Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık'];
    return months[m];
  }
}

