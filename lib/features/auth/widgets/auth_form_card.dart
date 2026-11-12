import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import 'auth_text_fields_section.dart';
import 'kvkk_checkbox_row.dart';

class AuthFormCard extends StatefulWidget {
  final bool isLoginMode;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback onToggleMode;
  final void Function(String email, String password) onLogin;
  final void Function(String name, String email, String phone, String password) onRegister;

  const AuthFormCard({
    super.key,
    required this.isLoginMode,
    required this.isLoading,
    this.errorMessage,
    required this.onToggleMode,
    required this.onLogin,
    required this.onRegister,
  });

  @override
  State<AuthFormCard> createState() => _AuthFormCardState();
}

class _AuthFormCardState extends State<AuthFormCard> {
  final _nameCtrl = TextEditingController(text: 'Ahmet Yılmaz');
  final _emailCtrl = TextEditingController(text: 'ahmet@wepet.com');
  final _phoneCtrl = TextEditingController(text: '+90 555 123 45 67');
  final _passwordCtrl = TextEditingController(text: '123456');
  bool _obscurePassword = true;
  bool _kvkkAccepted = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.errorMessage != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.redAccent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                widget.errorMessage!,
                style: const TextStyle(color: Colors.redAccent, fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 12),
          ],
          AuthTextFieldsSection(
            isLoginMode: widget.isLoginMode,
            obscurePassword: _obscurePassword,
            onTogglePasswordVisibility: () => setState(() => _obscurePassword = !_obscurePassword),
            nameController: _nameCtrl,
            emailController: _emailCtrl,
            phoneController: _phoneCtrl,
            passwordController: _passwordCtrl,
          ),
          if (!widget.isLoginMode)
            KvkkCheckboxRow(
              isAccepted: _kvkkAccepted,
              onChanged: (val) => setState(() => _kvkkAccepted = val),
            ),
          const SizedBox(height: 20),
          SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: widget.isLoading ? null : _submit,
              child: widget.isLoading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(color: AppColors.cardSurface, strokeWidth: 2.5),
                    )
                  : Text(widget.isLoginMode ? 'Giriş Yap' : 'Kayıt Ol'),
            ),
          ),
          const SizedBox(height: 14),
          TextButton(
            onPressed: widget.onToggleMode,
            child: Text(
              widget.isLoginMode
                  ? 'Hesabın yok mu? Hemen Kayıt Ol'
                  : 'Zaten üye misin? Giriş Yap',
              style: AppTextStyles.bodyMuted.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submit() {
    if (widget.isLoginMode) {
      widget.onLogin(_emailCtrl.text.trim(), _passwordCtrl.text.trim());
    } else {
      if (!_kvkkAccepted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Lütfen devam etmeden önce KVKK Aydınlatma Metni\'ni onaylayın.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }
      widget.onRegister(
        _nameCtrl.text.trim(),
        _emailCtrl.text.trim(),
        _phoneCtrl.text.trim(),
        _passwordCtrl.text.trim(),
      );
    }
  }
}
