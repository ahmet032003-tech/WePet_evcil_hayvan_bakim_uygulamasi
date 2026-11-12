import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../bloc/profile_bloc.dart';
import '../../bloc/profile_event.dart';
import '../../bloc/profile_state.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Ödeme Yöntemi', style: AppTextStyles.appBarTitle),
        centerTitle: true,
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          final cards = state is ProfileLoaded ? state.paymentCards : [];

          return Column(
            children: [
              Expanded(
                child: cards.isEmpty
                    ? const Center(
                        child: Text('Kayıtlı kart bulunmuyor.', style: AppTextStyles.bodyMuted),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: cards.length,
                        itemBuilder: (ctx, i) {
                          final card = cards[i];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.cardSurface,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: AppColors.softShadow,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryLight,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: const Icon(Icons.credit_card_rounded, color: AppColors.primary),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(card.cardHolder, style: AppTextStyles.cardTitle),
                                      const SizedBox(height: 4),
                                      Text('•••• •••• •••• ${card.lastFourDigits}', style: AppTextStyles.bodyMuted),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    context.read<ProfileBloc>().add(DeletePaymentMethod(card.id));
                                  },
                                  icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _openAddCardModal(context),
                    icon: const Icon(Icons.add),
                    label: const Text('Yeni Kart Ekle'),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _openAddCardModal(BuildContext context) {
    final holderController = TextEditingController();
    final digitsController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: EdgeInsets.fromLTRB(20, 16, 20, MediaQuery.of(context).viewInsets.bottom + 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Yeni Ödeme Kartı Ekle', style: AppTextStyles.heading2),
            const SizedBox(height: 14),
            TextField(
              controller: holderController,
              decoration: const InputDecoration(labelText: 'Kart Üzerindeki İsim'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: digitsController,
              keyboardType: TextInputType.number,
              maxLength: 4,
              decoration: const InputDecoration(labelText: 'Son 4 Hane (Örn: 1234)'),
            ),
            const SizedBox(height: 18),
            ElevatedButton(
              onPressed: () {
                final h = holderController.text.trim();
                final d = digitsController.text.trim();
                if (h.isNotEmpty && d.length == 4) {
                  context.read<ProfileBloc>().add(AddPaymentMethod(h, d));
                  Navigator.pop(context);
                }
              },
              child: const Text('Kartı Kaydet'),
            ),
          ],
        ),
      ),
    );
  }
}

