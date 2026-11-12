import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/models/pet_profile_model.dart';

class ProfilePetListSection extends StatelessWidget {
  final List<PetProfileModel> pets;
  final PetType selectedType;
  final void Function(String petId)? onDeletePet;

  const ProfilePetListSection({
    super.key,
    required this.pets,
    required this.selectedType,
    this.onDeletePet,
  });

  @override
  Widget build(BuildContext context) {
    if (pets.isEmpty) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: AppColors.softShadow,
        ),
        child: Center(
          child: Text(
            selectedType == PetType.dog
                ? 'Henüz kayıtlı bir köpeğin yok.'
                : 'Henüz kayıtlı bir kedin yok.',
            style: AppTextStyles.bodyMuted,
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: pets.map((pet) {
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.cardSurface,
              borderRadius: BorderRadius.circular(20),
              boxShadow: AppColors.softShadow,
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryLight,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    pet.type == PetType.dog ? Icons.pets : Icons.cruelty_free,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(pet.name, style: AppTextStyles.cardTitle),
                      const SizedBox(height: 2),
                      Text(
                        '${pet.breed ?? 'Melez'} • ${pet.age ?? 1} Yaşında',
                        style: AppTextStyles.bodyMuted,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => onDeletePet?.call(pet.id),
                  icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
