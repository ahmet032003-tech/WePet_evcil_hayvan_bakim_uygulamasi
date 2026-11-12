// Flutter temel Material UI bileşenlerini içe aktarır.
import 'package:flutter/material.dart';
// Uygulamanın merkezi renk paletini (Sıcak Amber, kart yüzey renkleri vb.) içe aktarır.
import '../../../core/constants/app_colors.dart';
// Uygulamanın tipografi ve başlık stillerini içe aktarır.
import '../../../core/constants/app_text_styles.dart';

/// Ana sayfanın üst çubuğu (AppBar).
/// Sol tarafta WePet logosu ve adı, sağ tarafta ise yüksek görünürlüklü kırmızı "ACİL" butonu yer alır.
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  // Kullanıcı sağ üstteki "ACİL" butonuna bastığında 7/24 Nöbetçi Veteriner Sheet'ini açan fonksiyon.
  final VoidCallback? onEmergencyTap;

  const HomeAppBar({
    super.key,
    this.onEmergencyTap,
  });

  // Standart AppBar yüksekliği olarak 64 piksel tanımlanır.
  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    // Çentikli telefon ekranlarında durum çubuğunun (status bar) altına taşmayı önler.
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Sol ve sağ bileşenleri iki uca iter
          children: [
            // Sol Bölüm: WePet Pati Logosu ve Marka İsmi
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary, // Sıcak Amber zemin
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: AppColors.softShadow,
                  ),
                  child: const Icon(
                    Icons.pets_rounded, // Pati ikonu
                    color: AppColors.surface, // Beyaz ikon
                    size: 20,
                  ),
                ),
                const SizedBox(width: 10), // Logo ile metin arası 10px boşluk
                Text(
                  'WePet',
                  style: AppTextStyles.heading1.copyWith(
                    color: AppColors.primary,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            // Sağ Bölüm: Kırmızı "ACİL" Nöbetçi Veteriner Butonu
            _EmergencyButton(onTap: onEmergencyTap ?? () {}),
          ],
        ),
      ),
    );
  }
}

/// Sağ üst köşede dikkat çeken, gölgeli ve parıltı efektli kırmızı acil durum butonu.
class _EmergencyButton extends StatelessWidget {
  final VoidCallback onTap;

  const _EmergencyButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // Dokunma aksiyonu
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFDC2626), // Dikkat çekici acil durum kırmızısı
          borderRadius: BorderRadius.circular(20), // Oval köşe tasarımı
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFDC2626).withValues(alpha: 0.38), // Kırmızı yumuşak ışıma gölgesi
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Acil durum ilk yardım / hastane ikonu
            Icon(
              Icons.emergency_rounded,
              color: Colors.white,
              size: 18,
            ),
            SizedBox(width: 6),
            // Kalın ve büyük harflerle "ACİL" yazısı
            Text(
              'ACİL',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 13,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
