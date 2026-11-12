import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class CampaignsBottomSheet extends StatelessWidget {
  const CampaignsBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const CampaignsBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    const campaigns = [
      (
        code: 'WELCOME200',
        title: '200 TL Hoş Geldin İndirimi',
        desc: 'WePet Shop ilk alışverişinde geçerli 200 TL sepet indirimi.',
        expiry: 'Son Gün: 30 Gün Sonra',
      ),
      (
        code: 'PATI10',
        title: '%10 Rutin Yürüyüş İndirimi',
        desc: 'Haftalık ve aylık rutin yürüyüş paketlerinde ekstra %10 indirim.',
        expiry: 'Süresiz',
      ),
      (
        code: 'WEPET20',
        title: 'WePet Bahar Kampanyası %20 İndirim',
        desc: 'Mobil pet kuaför ve evde bakım randevularınızda geçerlidir.',
        expiry: 'Son Gün: Bu Ay Sonu',
      ),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.fromLTRB(
        20,
        14,
        20,
        MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 44,
              height: 5,
              decoration: BoxDecoration(
                color: AppColors.borderLight,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.card_giftcard_rounded,
                  color: AppColors.primary,
                  size: 26,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text('Aktif Kuponlarım', style: AppTextStyles.heading2),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...campaigns.map(
            (c) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(c.title, style: AppTextStyles.cardTitle),
                        const SizedBox(height: 4),
                        Text(c.desc, style: AppTextStyles.bodyMuted),
                        const SizedBox(height: 6),
                        Text(
                          'KOD: ${c.code} • ${c.expiry}',
                          style: AppTextStyles.badgeText.copyWith(
                            color: AppColors.primary,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: c.code));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${c.code} panoya kopyalandı!'),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: AppColors.secondary,
                        ),
                      );
                    },
                    child: const Text('Kopyala'),
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

