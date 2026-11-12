import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class AuthTextFieldsSection extends StatelessWidget {
  final bool isLoginMode;
  final bool obscurePassword;
  final VoidCallback onTogglePasswordVisibility;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;

  const AuthTextFieldsSection({
    super.key,
    required this.isLoginMode,
    required this.obscurePassword,
    required this.onTogglePasswordVisibility,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!isLoginMode) ...[
          _buildField(
            controller: nameController,
            label: 'Ad Soyad',
            icon: Icons.person_outline_rounded,
          ),
          const SizedBox(height: 12),
        ],
        _buildField(
          controller: emailController,
          label: 'E-posta Adresi',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
        ),
        if (!isLoginMode) ...[
          const SizedBox(height: 12),
          _buildField(
            controller: phoneController,
            label: 'Telefon Numarası',
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
          ),
        ],
        const SizedBox(height: 12),
        TextFormField(
          controller: passwordController,
          obscureText: obscurePassword,
          decoration: InputDecoration(
            labelText: 'Şifre',
            prefixIcon: const Icon(Icons.lock_outline_rounded, color: AppColors.primary),
            suffixIcon: IconButton(
              icon: Icon(
                obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                color: AppColors.textMuted,
              ),
              onPressed: onTogglePasswordVisibility,
            ),
            filled: true,
            fillColor: AppColors.background,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.borderLight),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.primary),
        filled: true,
        fillColor: AppColors.background,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
      ),
    );
  }
}

