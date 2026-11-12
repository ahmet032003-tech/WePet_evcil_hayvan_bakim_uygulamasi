// Flutter temel görsel kütüphanesi
import 'package:flutter/material.dart';
// Uygulama renk paleti
import '../../../core/constants/app_colors.dart';
// Seçilen hizmetin dinamik tarife paket modelini içe aktarır
import '../../../core/models/service_package_option.dart';

/// Hizmete özel dinamik tarife ve süre seçeneklerini (30 dk, Tam Gün Evde Bakım, SPA vb.) listeleyen kapsül widget'ı.
class ServicePackageSelector extends StatelessWidget {
  // Bu hizmet için sunulan tüm paket seçeneklerinin listesi
  final List<ServicePackageOption> options;
  // Kullanıcının şu an seçmiş olduğu aktif paket
  final ServicePackageOption selectedOption;
  // Kullanıcı yeni bir pakete dokunduğunda çalışan geri çağırım (callback) fonksiyonu
  final ValueChanged<ServicePackageOption> onOptionSelected;

  const ServicePackageSelector({
    super.key,
    required this.options,
    required this.selectedOption,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Seçenekleri satıra sığmadığında alt satıra otomatik kaydıran Wrap widget'ı kullanılır.
    return Wrap(
      spacing: 8, // Çipler arası yatay boşluk (8px)
      runSpacing: 8, // Satırlar arası dikey boşluk (8px)
      children: options.map((opt) {
        // Bu seçeneğin şu an seçili olup olmadığını kontrol eder.
        final isSelected = opt.title == selectedOption.title;

        // Flutter'ın yerleşik tekli seçim çipi (ChoiceChip)
        return ChoiceChip(
          labelPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Paketin Adı (Örn: 45 Dakika, Tam SPA & Bakım Paketi)
              Text(
                opt.title,
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.textDark,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                  fontSize: 12.5,
                ),
              ),
              const SizedBox(width: 6),
              // Paketin Fiyatını Gösteren Küçük Kapsül (Örn: ₺380)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withValues(alpha: 0.25)
                      : AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '₺${opt.price.toInt()}',
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.primary,
                    fontWeight: FontWeight.w800,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          selected: isSelected, // Seçili durumu
          selectedColor: AppColors.primary, // Seçildiğinde Sıcak Amber rengini alır
          backgroundColor: AppColors.background, // Seçili değilken krem arka plan
          showCheckmark: false, // Varsayılan onay tik işaretini gizler
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: BorderSide(
              color: isSelected ? AppColors.primary : AppColors.borderLight,
            ),
          ),
          // Kullanıcı çipe dokunduğunda üst widget'a yeni seçilen paketi bildirir.
          onSelected: (_) => onOptionSelected(opt),
        );
      }).toList(),
    );
  }
}
