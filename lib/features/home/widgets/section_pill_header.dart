import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class SectionPillHeader extends StatelessWidget {
  final String title;

  const SectionPillHeader({
    super.key,
    this.title = 'DOSTUN İÇİN UYGUN HİZMETİ SEÇ!',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.35),
            width: 1.5,
          ),
          boxShadow: AppColors.softShadow,
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyles.sectionPillTitle,
        ),
      ),
    );
  }
}

