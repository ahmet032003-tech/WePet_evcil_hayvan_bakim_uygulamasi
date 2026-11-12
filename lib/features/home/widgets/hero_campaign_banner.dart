import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class HeroCampaignBanner extends StatelessWidget {
  final VoidCallback? onTap;

  const HeroCampaignBanner({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: AppColors.softShadow,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Image.asset(
            'assets/images/wepet_banner.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: 160,
          ),
        ),
      ),
    );
  }
}
