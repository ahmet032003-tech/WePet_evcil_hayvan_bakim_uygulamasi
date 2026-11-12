// Flutter temel widget kütüphanesi ve BLoC durum sağlayıcıları
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../profile/bloc/profile_bloc.dart';
import '../../profile/bloc/profile_state.dart';
import '../../profile/models/profile_extra_models.dart';

/// Kullanıcının kayıtlı ev adresini hazır seçili tutan ve manuel ilçe/semt araması sağlayan adres seçici.
class EmergencyAddressSelector extends StatefulWidget {
  // Seçilen veya aranan adres/semt değiştiğinde üst widget'a bildiren geri çağırım (callback).
  final ValueChanged<String> onAddressChanged;

  const EmergencyAddressSelector({super.key, required this.onAddressChanged});

  @override
  State<EmergencyAddressSelector> createState() => _EmergencyAddressSelectorState();
}

class _EmergencyAddressSelectorState extends State<EmergencyAddressSelector> {
  // Manuel arama metin kutusunu kontrol eden metin denetleyicisi.
  final _searchController = TextEditingController();
  // Ev adresinin mi yoksa özel aramanın mı seçili olduğunu tutan bayrak.
  bool _isHomeSelected = true;

  @override
  void dispose() {
    _searchController.dispose(); super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ProfileBloc'taki güncel kullanıcı profili ve kayıtlı adresleri dinler.
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        // Kullanıcının kayıtlı 'Ev' adresini bulur, yoksa ilk adresi alır.
        UserAddressModel? homeAddr;
        if (state is ProfileLoaded && state.addresses.isNotEmpty) {
          homeAddr = state.addresses.firstWhere((a) => a.title.toLowerCase().contains('ev'), orElse: () => state.addresses.first);
        }
        final fullAddress = homeAddr?.fullAddress ?? 'Fenerbahçe Mah. Lale Sok. No: 12 D: 4, Kadıköy / İstanbul';

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Mevcut Adresiniz', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.textDark)),
            const SizedBox(height: 8),
            _buildHomeCard(homeAddr?.title ?? 'Ev Adresi', fullAddress), // Kayıtlı Ev Adresi Kartı
            const SizedBox(height: 10),
            _buildSearchBar(), // Manuel Arama Kutusu ve "Bul" Butonu
          ],
        );
      },
    );
  }

  // Kullanıcının kayıtlı ev adresini gösteren ve tek dokunuşla seçtiren kart widget'ı.
  Widget _buildHomeCard(String title, String address) {
    return GestureDetector(
      onTap: () {
        setState(() { _isHomeSelected = true; _searchController.clear(); });
        widget.onAddressChanged(''); // Arama filtresini temizleyip ev adresine döner.
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _isHomeSelected ? const Color(0xFFFEE2E2) : AppColors.cardSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _isHomeSelected ? const Color(0xFFDC2626) : AppColors.borderLight, width: _isHomeSelected ? 1.5 : 1),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: _isHomeSelected ? const Color(0xFFDC2626) : AppColors.primaryLight, borderRadius: BorderRadius.circular(10)),
              child: Icon(Icons.home_rounded, size: 18, color: _isHomeSelected ? Colors.white : AppColors.primary),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
                      const SizedBox(width: 6),
                      if (_isHomeSelected)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                          decoration: BoxDecoration(color: const Color(0xFFDC2626), borderRadius: BorderRadius.circular(6)),
                          child: const Text('Seçili', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(address, style: const TextStyle(fontSize: 11.5, color: AppColors.textMuted), maxLines: 1, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Farklı bir semt/ilçe yazmak isteyen kullanıcılar için arama çubuğu ve butonu.
  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(fontSize: 12.5),
              decoration: const InputDecoration(
                hintText: 'Farklı bir ilçe veya semt ara (Örn: Beşiktaş)...',
                hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 11.5),
                prefixIcon: Icon(Icons.search_rounded, size: 18, color: AppColors.primary),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
              onSubmitted: (val) {
                setState(() => _isHomeSelected = false);
                widget.onAddressChanged(val);
              },
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          height: 44,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              padding: const EdgeInsets.symmetric(horizontal: 14),
            ),
            onPressed: () {
              final query = _searchController.text.trim();
              if (query.isNotEmpty) {
                setState(() => _isHomeSelected = false);
                widget.onAddressChanged(query);
              }
            },
            child: const Text('Bul', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}
