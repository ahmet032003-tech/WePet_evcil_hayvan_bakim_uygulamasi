import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../profile/bloc/profile_bloc.dart';
import '../../profile/bloc/profile_event.dart';
import '../../profile/models/profile_extra_models.dart';

class CheckoutPaymentSection extends StatelessWidget {
  final List<UserPaymentCardModel> paymentCards;
  final String? selectedCardId;
  final ValueChanged<String> onCardSelected;

  const CheckoutPaymentSection({
    super.key,
    required this.paymentCards,
    required this.selectedCardId,
    required this.onCardSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Ödeme Yöntemi', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
            TextButton.icon(
              onPressed: () => _openAddCardDialog(context),
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Yeni Kart', style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
        if (paymentCards.isEmpty)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Text('Kayıtlı kart bulunamadı. Lütfen yeni kart ekleyin.', style: TextStyle(fontSize: 12)),
          )
        else
          ...paymentCards.map((card) {
            final isSelected = card.id == selectedCardId;
            return GestureDetector(
              onTap: () => onCardSelected(card.id),
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
                    const Icon(Icons.credit_card_rounded, color: AppColors.primary, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(card.cardHolder, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5)),
                          Text('•••• •••• •••• ${card.lastFourDigits}',
                              style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
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

  void _openAddCardDialog(BuildContext context) {
    final holderCtrl = TextEditingController();
    final digitsCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Yeni Kart Ekle', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: holderCtrl, decoration: const InputDecoration(labelText: 'Kart Sahibi')),
            TextField(
              controller: digitsCtrl,
              keyboardType: TextInputType.number,
              maxLength: 4,
              decoration: const InputDecoration(labelText: 'Son 4 Hane (Örn: 5521)'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('İptal')),
          ElevatedButton(
            onPressed: () {
              if (holderCtrl.text.isNotEmpty && digitsCtrl.text.length == 4) {
                context.read<ProfileBloc>().add(AddPaymentMethod(holderCtrl.text.trim(), digitsCtrl.text.trim()));
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

