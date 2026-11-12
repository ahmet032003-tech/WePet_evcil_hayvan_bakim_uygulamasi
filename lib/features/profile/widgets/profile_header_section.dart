import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/models/pet_profile_model.dart';

class ProfileHeaderSection extends StatelessWidget {
  final PetType selectedPetType;
  final ValueChanged<PetType> onPetTypeChanged;
  final VoidCallback? onAddPetTap;
  final VoidCallback? onSettingsTap;

  const ProfileHeaderSection({
    super.key,
    required this.selectedPetType,
    required this.onPetTypeChanged,
    this.onAddPetTap,
    this.onSettingsTap,
  });

  @override
  Widget build(BuildContext context) {
    final addLabel =
        selectedPetType == PetType.dog ? 'Köpek Ekle' : 'Kedi Ekle';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(28)),
        boxShadow: AppColors.softShadow,
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                _SegmentedPetToggle(
                  selectedPetType: selectedPetType,
                  onChanged: onPetTypeChanged,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: onSettingsTap ?? () {},
                    icon: const Icon(
                      Icons.settings_outlined,
                      color: AppColors.surface,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: onAddPetTap ?? () {},
              child: Column(
                children: [
                  Container(
                    width: 78,
                    height: 78,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      shape: BoxShape.circle,
                      boxShadow: AppColors.softShadow,
                    ),
                    child: const Icon(
                      Icons.add_rounded,
                      color: AppColors.primary,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: AppColors.softShadow,
                    ),
                    child: Text(
                      addLabel,
                      style: AppTextStyles.cardTitle
                          .copyWith(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SegmentedPetToggle extends StatelessWidget {
  final PetType selectedPetType;
  final ValueChanged<PetType> onChanged;

  const _SegmentedPetToggle({
    required this.selectedPetType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSegmentItem('Köpeklerim', PetType.dog),
          _buildSegmentItem('Kedilerim', PetType.cat),
        ],
      ),
    );
  }

  Widget _buildSegmentItem(String title, PetType type) {
    final isSelected = selectedPetType == type;
    return GestureDetector(
      onTap: () => onChanged(type),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.surface : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: AppTextStyles.cardTitle.copyWith(
            fontSize: 12.5,
            color: isSelected ? AppColors.primary : AppColors.surface,
          ),
        ),
      ),
    );
  }
}
