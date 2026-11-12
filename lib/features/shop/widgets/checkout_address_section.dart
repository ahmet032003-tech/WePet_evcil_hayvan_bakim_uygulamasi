import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../profile/bloc/profile_bloc.dart';
import '../../profile/bloc/profile_event.dart';
import '../../profile/models/profile_extra_models.dart';

class CheckoutAddressSection extends StatelessWidget {
  final List<UserAddressModel> addresses;
  final String? selectedAddressId;
  final ValueChanged<String> onAddressSelected;

  const CheckoutAddressSection({
    super.key,
    required this.addresses,
    required this.selectedAddressId,
    required this.onAddressSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Teslimat Adresi', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
            TextButton.icon(
              onPressed: () => _openAddAddressDialog(context),
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Yeni Adres', style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
        if (addresses.isEmpty)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Text('Kayıtlı adres bulunamadı. Lütfen yeni adres ekleyin.', style: TextStyle(fontSize: 12)),
          )
        else
          ...addresses.map((addr) {
            final isSelected = addr.id == selectedAddressId;
            return GestureDetector(
              onTap: () => onAddressSelected(addr.id),
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primaryLight : AppColors.background,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.borderLight,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                      color: isSelected ? AppColors.primary : AppColors.textMuted,
                      size: 18,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(addr.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5)),
                          Text(
                            addr.fullAddress,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
      ],
    );
  }

  void _openAddAddressDialog(BuildContext context) {
    final titleCtrl = TextEditingController();
    final addressCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Yeni Adres Ekle', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: 'Adres Başlığı (Ev, İş)')),
            TextField(controller: addressCtrl, decoration: const InputDecoration(labelText: 'Açık Adres')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('İptal')),
          ElevatedButton(
            onPressed: () {
              if (titleCtrl.text.isNotEmpty && addressCtrl.text.isNotEmpty) {
                context.read<ProfileBloc>().add(AddAddress(titleCtrl.text.trim(), addressCtrl.text.trim()));
                Navigator.pop(ctx);
              }
            },
            child: const Text('Kaydet'),
          ),
        ],
      ),
    );
  }
}

