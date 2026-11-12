// Flutter'ın temel Material tasarım bileşenlerini ve widget sınıflarını içe aktarır.
import 'package:flutter/material.dart';
// Uygulamanın merkezi renk paletini (Sıcak Amber, kart yüzey renkleri vb.) içe aktarır.
import '../../../core/constants/app_colors.dart';
// Uygulamanın tipografi ve metin stillerini (başlık, gövde, buton stilleri) içe aktarır.
import '../../../core/constants/app_text_styles.dart';
// Seçilen hizmetin başlık, ikon, rozet gibi verilerini tutan veri modelini içe aktarır.
import '../../../core/models/service_item_model.dart';
// İkon veya kart üzerinde çapraz/düz kampanya rozeti göstermeyi sağlayan özel widget.
import '../../../core/widgets/badge_wrapper.dart';

/// Hizmet detay ve rezervasyon alt penceresinin (BottomSheet) üst başlık alanını çizen widget.
/// Seçilen hizmetin ikonunu, rozetini (varsa), başlığını ve kısa açıklamasını gösterir.
class ServiceDetailHeader extends StatelessWidget {
  // Bu başlıkta gösterilecek olan hizmete ait veri modeli (başlık, ikon, rozet vb.).
  final ServiceItemModel service;

  // Constructor: Üst widget'tan zorunlu olarak [service] parametresini alır.
  const ServiceDetailHeader({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    // Tüm başlık bileşenlerini dikey düzende hizalamak için Column kullanılır.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Metinleri ve içeriği sola hizalar.
      children: [
        // İkon kutusu ve hizmet başlığını yatayda yan yana dizmek için Row kullanılır.
        Row(
          children: [
            // Hizmetin varsa '%10', 'YENİ' gibi rozetini ikonun üzerine çapraz yerleştirir.
            BadgeWrapper(
              badgeText: service.badgeText, // Varsa rozet metni
              badgeColor: service.badgeColor, // Varsa rozet rengi
              isDiagonal: true, // Rozetin çapraz görünmesini sağlar
              child: Container(
                // İkonun etrafına iç boşluk (padding) ekler.
                padding: const EdgeInsets.all(12),
                // İkon arka planına yumuşak amber rengi ve yuvarlatılmış köşeler verir.
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(16),
                ),
                // Hizmete ait özgün ikonu ana tema renginde (Primary Amber) çizer.
                child: Icon(service.icon, color: AppColors.primary, size: 28),
              ),
            ),
            // İkon ile başlık metni arasına 14 piksel yatay boşluk bırakır.
            const SizedBox(width: 14),
            // Başlık metninin ekrandan taşmasını önlemek ve kalan alanı kaplamasını sağlamak için Expanded.
            Expanded(
              child: Text(
                service.title, // Hizmetin adı (örn: TEK YÜRÜYÜŞ, KÖPEK EVDE BAKIM)
                style: AppTextStyles.heading2.copyWith(fontSize: 18), // Vurgulu başlık stili
              ),
            ),
          ],
        ),
        // Üst satır ile alttaki açıklama metni arasına 12 piksel dikey boşluk ekler.
        const SizedBox(height: 12),
        // Kullanıcıya seçtiği hizmetin güvenilir ve profesyonel olduğunu belirten açıklama metni.
        Text(
          'Eğitimli ve güvenilir walker dostlarımız ile köpeğin için güvenli tek seferlik yürüyüş deneyimi.',
          style: AppTextStyles.bodyMuted.copyWith(fontSize: 13), // Soluk gri gövde metni
        ),
      ],
    );
  }
}
