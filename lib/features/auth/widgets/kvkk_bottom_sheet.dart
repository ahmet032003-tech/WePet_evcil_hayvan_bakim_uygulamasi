// Flutter temel UI bileşenlerini içe aktarır.
import 'package:flutter/material.dart';
// Uygulama renk paleti ve tipografi stilleri.
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

/// 6698 sayılı Kişisel Verilerin Korunması Kanunu (KVKK) Aydınlatma Metni modal bottom sheet bileşeni.
class KvkkBottomSheet extends StatelessWidget {
  const KvkkBottomSheet({super.key});

  /// Metni modal alt pencere olarak gösteren yardımcı statik fonksiyon.
  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const KvkkBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Ekran yüksekliğinin %80'ini kaplayacak şekilde sınırlandırılır.
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      decoration: const BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Üst tutma çubuğu (drag handle)
          Center(
            child: Container(
              width: 44,
              height: 5,
              decoration: BoxDecoration(
                color: AppColors.borderLight,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Başlık
          const Text('KVKK Aydınlatma Metni', style: AppTextStyles.heading2),
          const SizedBox(height: 4),
          const Text('6698 Sayılı Kanun Kapsamında Bilgilendirme', style: AppTextStyles.bodyMuted),
          const SizedBox(height: 12),
          const Divider(color: AppColors.borderLight, height: 1),
          // Kaydırılabilir metin içeriği
          const Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _KvkkSection(
                    title: '1. Veri Sorumlusu',
                    content: 'WePet Teknoloji A.Ş. ("WePet") olarak kişisel verilerinizin güvenliğine ve gizliliğine azami hassasiyet göstermekteyiz.',
                  ),
                  _KvkkSection(
                    title: '2. İşlenen Kişisel Veriler',
                    content: 'Ad-soyad, telefon numarası, e-posta adresi, evcil hayvanlarınızın profilleri ve konum bilgileriniz güvenli sunucularda saklanır.',
                  ),
                  _KvkkSection(
                    title: '3. Veri İşleme Amaçları',
                    content: 'Evcil hayvan gezdirme, pansiyon, acil veteriner erişimi ve rezervasyon süreçlerinin sorunsuz yönetilmesi amacıyla işlenmektedir.',
                  ),
                  _KvkkSection(
                    title: '4. Haklarınız',
                    content: 'KVKK 11. madde uyarınca verilerinizin silinmesini, düzeltilmesini ve işlenme durumunu öğrenmeyi her zaman talep edebilirsiniz.',
                  ),
                ],
              ),
            ),
          ),
          // Kapat butonu
          SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text('Anladım ve Kapat', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}

/// Başlık ve açıklamadan oluşan KVKK metin paragrafı.
class _KvkkSection extends StatelessWidget {
  final String title;
  final String content;

  const _KvkkSection({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.cardTitle.copyWith(color: AppColors.primary, fontSize: 14)),
          const SizedBox(height: 4),
          Text(content, style: AppTextStyles.bodyRegular.copyWith(height: 1.45, fontSize: 13)),
        ],
      ),
    );
  }
}
