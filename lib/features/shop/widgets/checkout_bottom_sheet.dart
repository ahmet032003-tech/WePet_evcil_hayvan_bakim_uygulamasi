import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/repositories/auth_repository.dart';
import '../../../core/repositories/shop_repository.dart';
import '../../profile/bloc/profile_bloc.dart';
import '../../profile/bloc/profile_state.dart';
import '../bloc/shop_bloc.dart';
import '../bloc/shop_event.dart';
import '../bloc/shop_state.dart';
import 'checkout_address_section.dart';
import 'checkout_payment_section.dart';

class CheckoutBottomSheet extends StatefulWidget {
  final ShopBloc shopBloc;
  const CheckoutBottomSheet({super.key, required this.shopBloc});

  static Future<void> show(BuildContext context, ShopBloc shopBloc) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CheckoutBottomSheet(shopBloc: shopBloc),
    );
  }

  @override
  State<CheckoutBottomSheet> createState() => _CheckoutBottomSheetState();
}

class _CheckoutBottomSheetState extends State<CheckoutBottomSheet> {
  String? _selectedAddressId;
  String? _selectedCardId;

  @override
  Widget build(BuildContext context) {
    final shopState = widget.shopBloc.state;
    if (shopState is! ShopLoaded) return const SizedBox.shrink();

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.fromLTRB(20, 14, 20, MediaQuery.of(context).viewInsets.bottom + 24),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, profileState) {
          final addresses = profileState is ProfileLoaded ? profileState.addresses : [];
          final cards = profileState is ProfileLoaded ? profileState.paymentCards : [];

          if (_selectedAddressId == null && addresses.isNotEmpty) _selectedAddressId = addresses.first.id;
          if (_selectedCardId == null && cards.isNotEmpty) _selectedCardId = cards.first.id;

          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 44,
                    height: 5,
                    decoration: BoxDecoration(color: AppColors.borderLight, borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 14),
                const Text('Sipariş Özeti & Ödeme', style: AppTextStyles.heading2),
                const SizedBox(height: 16),
                CheckoutAddressSection(
                  addresses: addresses.cast(),
                  selectedAddressId: _selectedAddressId,
                  onAddressSelected: (id) => setState(() => _selectedAddressId = id),
                ),
                const SizedBox(height: 14),
                CheckoutPaymentSection(
                  paymentCards: cards.cast(),
                  selectedCardId: _selectedCardId,
                  onCardSelected: (id) => setState(() => _selectedCardId = id),
                ),
                const SizedBox(height: 16),
                _buildTotalRow(shopState.totalAmount),
                const SizedBox(height: 18),
                ElevatedButton(
                  onPressed: () => _confirmOrder(addresses.cast(), cards.cast(), shopState),
                  child: const Text('Ödemeyi Tamamla & Sipariş Ver'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTotalRow(double total) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Ödenecek Tutar:', style: AppTextStyles.cardTitle),
        Text('₺${total.toStringAsFixed(2)}', style: AppTextStyles.heading1.copyWith(color: AppColors.primary, fontSize: 20)),
      ],
    );
  }

  Future<void> _confirmOrder(List addresses, List cards, ShopLoaded shopState) async {
    if (_selectedAddressId == null || _selectedCardId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen teslimat adresi ve ödeme yöntemi seçin.'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    final targetAddr = addresses.firstWhere((a) => a.id == _selectedAddressId);
    final targetCard = cards.firstWhere((c) => c.id == _selectedCardId);
    final user = AuthRepository().currentUser;
    if (user != null) {
      try {
        await ShopRepository().createOrder(
          uid: user.uid, items: shopState.cartItems, totalAmount: shopState.totalAmount,
          addressTitle: targetAddr.title, cardLastFour: targetCard.lastFourDigits,
        );
      } catch (_) {}
    }
    widget.shopBloc.add(const ClearCartAndCheckout());
    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Siparişiniz ${targetAddr.title} adresine gönderilmek üzere alındı! 🐾'),
          backgroundColor: AppColors.secondary,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
