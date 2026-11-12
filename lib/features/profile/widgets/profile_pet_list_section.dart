import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/models/pet_profile_model.dart';

class ProfilePetListSection extends StatelessWidget {
  final List<PetProfileModel> pets;
  final PetType selectedType;
  final VoidCallback? onAddPet;
  final void Function(String petId)? onDeletePet;

  const ProfilePetListSection({
    super.key,
    required this.pets,
    required this.selectedType,
    this.onAddPet,
    this.onDeletePet,
  });

  @override
  Widget build(BuildContext context) {
    if (pets.isEmpty) {
      final typeLabel = selectedType == PetType.dog ? 'köpeğin' : 'kedin';
      final addLabel = selectedType == PetType.dog ? 'Köpek Ekle' : 'Kedi Ekle';
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
        decoration: BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: AppColors.softShadow,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: Icon(
                selectedType == PetType.dog ? Icons.pets : Icons.cruelty_free,
                color: AppColors.primary,
                size: 28,
              ),
            ),
            const SizedBox(height: 12),
            Text('Henüz kayıtlı bir $typeLabel yok', style: AppTextStyles.cardTitle),
            const SizedBox(height: 4),
            const Text(
              'Profiline dostunu ekleyerek hemen randevu ve bakım hizmetlerinden faydalanabilirsin.',
              style: AppTextStyles.bodyMuted,
              textAlign: TextAlign.center,
            ),
            if (onAddPet != null) ...[
              const SizedBox(height: 14),
              ElevatedButton.icon(
                onPressed: onAddPet,
                icon: const Icon(Icons.add, size: 18),
                label: Text(addLabel),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ],
          ],
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
