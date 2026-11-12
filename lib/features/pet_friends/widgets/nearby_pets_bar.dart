import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../models/pet_friend_post_model.dart';

class NearbyPetsBar extends StatelessWidget {
  final List<PetFriendPostModel> nearbyPets;

  const NearbyPetsBar({super.key, required this.nearbyPets});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('Yakındaki Oyun Arkadaşları', style: AppTextStyles.cardTitle),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 98,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: nearbyPets.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final pet = nearbyPets[index];
              return Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryLight,
                          border: Border.all(color: AppColors.primary, width: 1.5),
                        ),
                        child: const Icon(Icons.pets_rounded, color: AppColors.primary, size: 24),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.secondary,
                            border: Border.all(color: AppColors.cardSurface, width: 2),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(pet.petName, style: AppTextStyles.cardTitle.copyWith(fontSize: 12)),
                  Text(pet.distance, style: AppTextStyles.bodyMuted.copyWith(fontSize: 10)),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

