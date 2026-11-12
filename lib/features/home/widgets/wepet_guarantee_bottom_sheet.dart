import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class WePetGuaranteeBottomSheet extends StatelessWidget {
  const WePetGuaranteeBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const WePetGuaranteeBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    const guarantees = [
      (
        icon: Icons.verified_user_rounded,
        title: 'Adli Sicil & Güvenlik Taraması',
        desc: 'Tüm walker adayları kapsamlı mülakat ve güvenlik taramasından geçirilir.',
      ),
      (
        icon: Icons.medical_services_rounded,
        title: '7/24 Anlaşmalı Veteriner Desteği',
        desc: 'Yürüyüş ve bakım süresince anlık acil veteriner ve konsültasyon hattı aktiftir.',
      ),
      (
        icon: Icons.health_and_safety_rounded,
        title: 'Pati Sağlık ve Sorumluluk Sigortası',
        desc: 'Her hizmet başlangıcından bitişine kadar WePet güvencesiyle sigortalanır.',
      ),
      (
        icon: Icons.gps_fixed_rounded,
        title: 'Canlı GPS ve Rota Takibi',
        desc: 'Yürüyüş boyunca adım, rota ve tuvalet bildirimlerini canlı izleyebilirsiniz.',
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
                  Icons.shield_rounded,
                  color: AppColors.primary,
                  size: 26,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text('WePet Güvencesi', style: AppTextStyles.heading2),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...guarantees.map(
            (g) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 2),
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(g.icon, size: 16, color: AppColors.primary),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(g.title, style: AppTextStyles.cardTitle.copyWith(fontSize: 13.5)),
                        const SizedBox(height: 2),
                        Text(g.desc, style: AppTextStyles.bodyMuted.copyWith(fontSize: 11.5)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Anladım'),
          ),
        ],
      ),
    );
  }
}

