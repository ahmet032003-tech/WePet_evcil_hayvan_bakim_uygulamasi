// Flutter temel UI bileşenlerini içe aktarır.
import 'package:flutter/material.dart';
// Uygulama renk paleti ve stilleri.
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
// KVKK detay penceresi
import 'kvkk_bottom_sheet.dart';

/// Kayıt ekranında kullanıcının KVKK Aydınlatma Metni'ni onaylamasını sağlayan Checkbox ve metin satırı.
class KvkkCheckboxRow extends StatelessWidget {
  final bool isAccepted;
  final ValueChanged<bool> onChanged;

  const KvkkCheckboxRow({
    super.key,
    required this.isAccepted,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Onay kutucuğu
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: isAccepted,
              activeColor: AppColors.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              onChanged: (val) => onChanged(val ?? false),
            ),
          ),
          const SizedBox(width: 8),
          // Tıklanabilir metin
          Expanded(
            child: GestureDetector(
              onTap: () => KvkkBottomSheet.show(context),
              child: RichText(
                text: TextSpan(
                  style: AppTextStyles.bodyRegular.copyWith(fontSize: 12),
                  children: [
                    TextSpan(
                      text: 'KVKK Aydınlatma Metni',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primary,
                      ),
                    ),
                    const TextSpan(text: '\'ni okudum, onaylıyorum.'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
