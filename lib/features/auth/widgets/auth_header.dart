import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class AuthHeader extends StatelessWidget {
  final bool isLoginMode;

  const AuthHeader({super.key, required this.isLoginMode});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 84,
          height: 84,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: AppColors.softShadow,
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/images/wepet_logo.png',
              width: 84,
              height: 84,
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'WePet',
          style: AppTextStyles.heading1.copyWith(
            fontSize: 32,
            color: AppColors.primary,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          isLoginMode
              ? 'Dostunla yeni maceralara hazır mısın?'
              : 'WePet ailesine katıl, dostuna en iyi bakımı sağla!',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyMuted.copyWith(fontSize: 13.5),
        ),
      ],
    );
  }
}

