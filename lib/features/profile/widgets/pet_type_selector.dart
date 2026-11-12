import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/models/pet_profile_model.dart';

class PetTypeSelector extends StatelessWidget {
  final PetType selectedType;
  final ValueChanged<PetType> onTypeChanged;

  const PetTypeSelector({
    super.key,
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          _buildOption('Köpek', PetType.dog),
          _buildOption('Kedi', PetType.cat),
        ],
      ),
    );
  }

  Widget _buildOption(String title, PetType type) {
    final isSelected = selectedType == type;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTypeChanged(type),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? AppColors.cardSurface : AppColors.textDark,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

