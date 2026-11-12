// Flutter temel görsel arayüz kütüphanesi
import 'package:flutter/material.dart';
// Uygulama renk paleti (Sıcak Amber, yüzey renkleri)
import '../../../core/constants/app_colors.dart';
// Tipografi ve metin stilleri (başlık, buton, soluk gövde metinleri)
import '../../../core/constants/app_text_styles.dart';

/// WePet Shop tanıtım ve karşılama alanının altındaki 200 TL kupon kazandıran alt bilgi (footer) widget'ı.
class ShopWelcomeFooter extends StatelessWidget {
  // Kullanıcı "Şimdi 200 TL Kazan! >" butonuna bastığında çalışacak tetikleyici fonksiyon.
  final VoidCallback onActionTap;

  const ShopWelcomeFooter({
    super.key,
    required this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    // İçeriği dikey eksende en az yer kaplayacak şekilde düzenler.
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Mağaza karşılama büyük başlığı
        Text(
          "WePet Shop'a Hoş Geldin!",
          textAlign: TextAlign.center,
          style: AppTextStyles.heading1.copyWith(fontSize: 25),
        ),
        const SizedBox(height: 12), // Başlık ile açıklama arası dikey boşluk
        // Kullanıcıyı alışverişe ve WePet güvencesine teşvik eden açıklama paragrafı
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Dostunun ihtiyacı olan mama, ödül, oyuncak ve bakım ürünlerini '
            'WePet güvencesiyle keşfet, ilk siparişine özel hediye fırsatını kaçırma!',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMuted.copyWith(fontSize: 14),
          ),
        ),
        const SizedBox(height: 32), // Açıklama ile aksiyon butonu arası dikey boşluk
        // Tam genişlikli ve 56 piksel yüksekliğinde modern aksiyon butonu
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: onActionTap, // Tıklandığında kupon kopyalama diyaloğunu açar
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary, // Sıcak Amber ana rengi
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // 20 piksel yuvarlatılmış köşeler
              ),
            ),
            child: const Text(
              'Şimdi 200 TL Kazan! >',
              style: AppTextStyles.buttonText, // Kalın beyaz buton yazı stili
            ),
          ),
        ),
      ],
    );
  }
}
