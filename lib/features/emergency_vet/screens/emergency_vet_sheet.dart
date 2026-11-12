// Flutter temel arayüz paketleri ve tasarım sabitleri
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../models/emergency_vet_clinic_model.dart';
import '../widgets/emergency_address_selector.dart';
import '../widgets/emergency_vet_clinic_card.dart';

/// Kullanıcı "ACİL" butonuna bastığında alttan açılan 7/24 Nöbetçi Veteriner arama ve listeleme sayfası.
class EmergencyVetSheet extends StatefulWidget {
  const EmergencyVetSheet({super.key});

  // Bu BottomSheet'i herhangi bir ekrandan çağırmayı sağlayan statik yardımcı metot.
  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Ekran yüksekliğinin %88'ini kaplayabilmesi için.
      backgroundColor: Colors.transparent, // Köşe yuvarlatmalarının düzgün görünmesi için.
      builder: (_) => const EmergencyVetSheet(),
    );
  }

  @override
  State<EmergencyVetSheet> createState() => _EmergencyVetSheetState();
}

class _EmergencyVetSheetState extends State<EmergencyVetSheet> {
  // Kullanıcının yazdığı ilçe veya seçtiği adrese göre klinik listesini filtreleyen metin.
  String _filter = '';

  @override
  Widget build(BuildContext context) {
    // Filtreye uygun klinikleri süzer; arama boşsa veya eşleşme yoksa güvenli şekilde tüm acil klinikleri listeler.
    final filtered = EmergencyVetClinicModel.sampleClinics.where((c) {
      if (_filter.isEmpty || _filter.contains('Mevcut') || _filter.contains('Ev')) return true;
      final query = _filter.toLowerCase();
      return c.name.toLowerCase().contains(query) || c.district.toLowerCase().contains(query) || c.address.toLowerCase().contains(query);
    }).toList();
    final clinics = filtered.isNotEmpty ? filtered : EmergencyVetClinicModel.sampleClinics;

    return Container(
      height: MediaQuery.of(context).size.height * 0.88,
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDragHandle(), // Sürüklenebilir çekme çubuğu
          const SizedBox(height: 12),
          _buildHeader(), // Kırmızı Acil Başlık ve Alt Başlık
          const SizedBox(height: 12),
          _buildWarningBox(), // Hayati Durum Uyarı Kutusu
          const SizedBox(height: 12),
          // Kullanıcı Adresi ve Arama Çubuğu Bileşeni
          EmergencyAddressSelector(
            onAddressChanged: (val) => setState(() => _filter = val),
          ),
          const SizedBox(height: 14),
          // Liste Başlığı ve Bulunan Klinik Sayacı
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('En Yakın 7/24 Nöbetçi Klinikler', style: AppTextStyles.cardTitle),
              Text('${clinics.length} klinik', style: AppTextStyles.bodyMuted.copyWith(fontSize: 12)),
            ],
          ),
          const SizedBox(height: 10),
          // Klinik Kartlarını Listeleyen Kaydırılabilir Liste
          Expanded(
            child: ListView.builder(
              itemCount: clinics.length,
              itemBuilder: (_, index) => EmergencyVetClinicCard(clinic: clinics[index]),
            ),
          ),
        ],
      ),
    );
  }

  // BottomSheet'in üstündeki tutma/kapatma çubuğu
  Widget _buildDragHandle() {
    return Center(
      child: Container(
        width: 44, height: 5,
        decoration: BoxDecoration(color: AppColors.borderLight, borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  // Kırmızı acil durum ikonu ve başlık alanı
  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: const Color(0xFFFEE2E2), borderRadius: BorderRadius.circular(14)),
          child: const Icon(Icons.emergency_rounded, color: Color(0xFFDC2626), size: 26),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('7/24 Nöbetçi Acil Veteriner', style: AppTextStyles.heading2),
              SizedBox(height: 2),
              Text('Acil durumlarda en yakın açık veteriner kliniğini bulun', style: AppTextStyles.bodyMuted),
            ],
          ),
        ),
      ],
    );
  }

  // Hayati tehlike durumlarında kliniğe gitmeden önce arama yapılmasını hatırlatan sarı uyarı kutusu
  Widget _buildWarningBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF3C7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFCD34D)),
      ),
      child: const Row(
        children: [
          Icon(Icons.info_outline_rounded, color: Color(0xFFD97706), size: 18),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Acil durumlarda gitmeden önce kliniği arayarak hekim hazırlığı isteyiniz.',
              style: TextStyle(color: Color(0xFF92400E), fontSize: 11.5, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
