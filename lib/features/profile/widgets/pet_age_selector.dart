import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class PetAgeSelector extends StatelessWidget {
  final int age;
  final ValueChanged<int> onAgeChanged;

  const PetAgeSelector({
    super.key,
    required this.age,
    required this.onAgeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Yaşı:', style: AppTextStyles.bodyRegular),
        Row(
          children: [
            IconButton(
              onPressed: age > 1 ? () => onAgeChanged(age - 1) : null,
              icon: const Icon(Icons.remove_circle_outline, color: AppColors.primary),
            ),
            Text('$age Yaş', style: AppTextStyles.cardTitle),
            IconButton(
              onPressed: age < 20 ? () => onAgeChanged(age + 1) : null,
              icon: const Icon(Icons.add_circle_outline, color: AppColors.primary),
            ),
          ],
        ),
      ],
    );
  }
}

