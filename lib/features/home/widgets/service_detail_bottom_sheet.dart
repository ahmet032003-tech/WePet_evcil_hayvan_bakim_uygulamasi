// Flutter temel Material UI bileşenleri
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/models/service_item_model.dart';
import '../../../core/models/service_package_option.dart';
import 'reservation_date_time_picker.dart';
import 'service_detail_header.dart';
import 'service_package_selector.dart';

/// Kullanıcı ana sayfadaki bir hizmete tıkladığında alttan açılan detay ve rezervasyon alt penceresi.
class ServiceDetailBottomSheet extends StatefulWidget {
  final ServiceItemModel service; // Seçilen hizmet modeli
  // Rezervasyon tamamlandığında seçilen tarih, saat dilimi ve paketi ileten geri çağırım.
  final void Function(DateTime date, String timeSlot, ServicePackageOption package)? onBooked;

  const ServiceDetailBottomSheet({
    super.key,
    required this.service,
    this.onBooked,
  });

  // Modal penceresini ekranın altına açan statik yardımcı metot.
  static Future<void> show(
    BuildContext context,
    ServiceItemModel service, {
    void Function(DateTime date, String timeSlot, ServicePackageOption package)? onBooked,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Klavye ve içerik yüksekliğine göre genişlemesini sağlar.
      backgroundColor: Colors.transparent, // Üst yuvarlatılmış köşelerin düzgün görünmesi için.
      builder: (_) => ServiceDetailBottomSheet(
        service: service,
        onBooked: onBooked,
      ),
    );
  }

  @override
  State<ServiceDetailBottomSheet> createState() => _ServiceDetailBottomSheetState();
}

class _ServiceDetailBottomSheetState extends State<ServiceDetailBottomSheet> {
  late final ServiceTariffConfig _tariffConfig; // Bu hizmete özel tarife yapılandırması
  late ServicePackageOption _selectedOption; // Kullanıcının şu an seçili tuttuğu tarife paketi
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1)); // Varsayılan olarak yarınki tarih
  String _selectedTimeSlot = '14:00'; // Varsayılan randevu saati

  @override
  void initState() {
    super.initState();
    // Hizmetin tipine göre dinamik paketleri yükler ve ilk seçeneği varsayılan seçer.
    _tariffConfig = ServiceTariffConfig.forService(widget.service.id, widget.service.title);
    _selectedOption = _tariffConfig.options.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.fromLTRB(20, 14, 20, MediaQuery.of(context).viewInsets.bottom + 24),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildDragHandle(), // Sürüklenebilir tutma çubuğu
            const SizedBox(height: 14),
            ServiceDetailHeader(service: widget.service), // Hizmet İkonu, Başlığı ve Açıklaması
            const SizedBox(height: 16),
            Text(_tariffConfig.sectionTitle, style: AppTextStyles.cardTitle), // Dinamik Bölüm Başlığı
            const SizedBox(height: 10),
            // Hizmete Özel Dinamik Paket Seçim Kapsülleri
            ServicePackageSelector(
              options: _tariffConfig.options,
              selectedOption: _selectedOption,
              onOptionSelected: (opt) => setState(() => _selectedOption = opt),
            ),
            const SizedBox(height: 14),
            // Takvim ve Saat Dilimi Seçicisi
            ReservationDateTimePicker(
              selectedDate: _selectedDate,
              selectedTimeSlot: _selectedTimeSlot,
              onDateChanged: (d) => setState(() => _selectedDate = d),
              onTimeSlotChanged: (t) => setState(() => _selectedTimeSlot = t),
            ),
            const SizedBox(height: 14),
            _buildPriceRow(), // Tahmini Tutar Satırı (Anlık güncellenir)
            const SizedBox(height: 16),
            _buildSubmitButton(context), // "Rezervasyon Oluştur" Onay Butonu
          ],
        ),
      ),
    );
  }

  Widget _buildDragHandle() {
    return Center(
      child: Container(
        width: 44, height: 5,
        decoration: BoxDecoration(color: AppColors.borderLight, borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  // Seçilen pakete göre toplam ücreti gösteren satır.
  Widget _buildPriceRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Tahmini Tutar:', style: AppTextStyles.bodyRegular),
        Text(
          '₺${_selectedOption.price.toInt()}',
          style: AppTextStyles.heading1.copyWith(color: AppColors.primary, fontSize: 22),
        ),
      ],
    );
  }

  // Rezervasyonu tamamlayan ve geri bildirim SnackBar'ı gösteren buton.
  Widget _buildSubmitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.onBooked?.call(_selectedDate, _selectedTimeSlot, _selectedOption);
        Navigator.pop(context);
        final dateStr = '${_selectedDate.day} ${_getMonthName(_selectedDate.month)}';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$dateStr - $_selectedTimeSlot: ${widget.service.title} (${_selectedOption.title}) rezervasyonu oluşturuldu!'),
            backgroundColor: AppColors.secondary,
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      child: const Text('Rezervasyon Oluştur'),
    );
  }

  String _getMonthName(int month) {
    const m = ['', 'Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran', 'Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık'];
    return m[month];
  }
}
