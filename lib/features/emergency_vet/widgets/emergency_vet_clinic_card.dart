// Flutter temel arayüz kütüphanesi ve harici uygulama açıcı (url_launcher) paketi
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../models/emergency_vet_clinic_model.dart';

/// 7/24 Nöbetçi Veteriner kliniğinin adını, mesafesini, puanını ve acil aksiyonlarını listeleyen kart.
class EmergencyVetClinicCard extends StatelessWidget {
  final EmergencyVetClinicModel clinic; // Kartta gösterilecek klinik bilgisi

  const EmergencyVetClinicCard({super.key, required this.clinic});

  // Telefon uygulamasını 'tel:' şemasıyla başlatarak kliniği doğrudan arar.
  Future<void> _callClinic(BuildContext context) async {
    final cleanPhone = clinic.phone.replaceAll(RegExp(r'\s+'), '');
    final uri = Uri.parse('tel:$cleanPhone');
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${clinic.phone} aranıyor...'), backgroundColor: const Color(0xFF16A34A)),
        );
      }
    }
  }

  // Google Maps'i sürüş modu ve hedef klinik koordinatı/adresi ile açarak canlı rota çizer.
  Future<void> _openGoogleMaps(BuildContext context) async {
    final encoded = Uri.encodeComponent('${clinic.name}, ${clinic.address}');
    final url = Uri.parse('https://www.google.com/maps/dir/?api=1&destination=$encoded&travelmode=driving');
    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${clinic.name} haritada açılıyor...'), backgroundColor: AppColors.primary),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppColors.softShadow,
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Üst Satır: Kırmızı Hastane İkonu, Klinik Adı, 7/24 Açık Rozeti ve Puan
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: const Color(0xFFFEE2E2), borderRadius: BorderRadius.circular(14)),
                child: const Icon(Icons.local_hospital_rounded, color: Color(0xFFDC2626), size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(clinic.name, style: AppTextStyles.cardTitle.copyWith(fontSize: 14.5)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        // Yeşil 7/24 Nöbetçi Rozeti
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(color: const Color(0xFFDCFCE7), borderRadius: BorderRadius.circular(8)),
                          child: const Text('7/24 Açık', style: TextStyle(color: Color(0xFF16A34A), fontSize: 11, fontWeight: FontWeight.w700)),
                        ),
                        const SizedBox(width: 6),
                        // Mesafe Bilgisi (örn: 1.2 km)
                        Text('•  ${clinic.distance}', style: AppTextStyles.bodyMuted.copyWith(fontSize: 12)),
                        const Spacer(),
                        // Değerlendirme Yıldızı ve Puanı
                        const Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 16),
                        Text(' ${clinic.rating}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Kliniğin Açık Adresi
          Text(clinic.address, style: AppTextStyles.bodyMuted.copyWith(fontSize: 12.5)),
          const SizedBox(height: 12),
          const Divider(height: 1, color: AppColors.borderLight),
          const SizedBox(height: 10),
          // Alt Aksiyon Butonları: "Hemen Ara" ve "Yol Tarifi Al"
          Row(
            children: [
              // 1. Acil Çağrı Butonu (Yeşil)
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF16A34A),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => _callClinic(context),
                  icon: const Icon(Icons.phone_in_talk_rounded, size: 16, color: Colors.white),
                  label: const Text('Hemen Ara', style: TextStyle(color: Colors.white, fontSize: 12.5, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 10),
              // 2. Google Maps Canlı Navigasyon Butonu
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    side: const BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => _openGoogleMaps(context),
                  icon: const Icon(Icons.directions_rounded, size: 16, color: AppColors.primary),
                  label: const Text('Yol Tarifi Al', style: TextStyle(color: AppColors.primary, fontSize: 12.5, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
