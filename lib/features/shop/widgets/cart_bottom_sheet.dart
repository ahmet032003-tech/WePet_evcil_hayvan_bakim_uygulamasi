import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../bloc/shop_bloc.dart';
import '../bloc/shop_event.dart';
import '../bloc/shop_state.dart';
import 'cart_coupon_section.dart';
import 'cart_item_list.dart';
import 'cart_total_summary.dart';
import 'checkout_bottom_sheet.dart';

class CartBottomSheet extends StatefulWidget {
  final ShopBloc shopBloc;

  const CartBottomSheet({super.key, required this.shopBloc});

  static Future<void> show(BuildContext context, ShopBloc bloc) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CartBottomSheet(shopBloc: bloc),
    );
  }

  @override
  State<CartBottomSheet> createState() => _CartBottomSheetState();
}

class _CartBottomSheetState extends State<CartBottomSheet> {
  final _couponController = TextEditingController();

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.shopBloc.state;
    if (state is! ShopLoaded) return const SizedBox.shrink();

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.fromLTRB(
        20,
        14,
        20,
        MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildDragHandle(),
            const SizedBox(height: 14),
            Row(
              children: [
                const Icon(Icons.shopping_bag_rounded, color: AppColors.primary),
                const SizedBox(width: 10),
                Text('Sepetim (${state.totalItemCount})', style: AppTextStyles.heading2),
              ],
            ),
            const SizedBox(height: 14),
            CartItemList(
              items: state.cartItems,
              onQuantityChanged: (id, delta) {
                widget.shopBloc.add(UpdateQuantity(id, delta));
                setState(() {});
              },
            ),
            const SizedBox(height: 14),
            CartCouponSection(
              controller: _couponController,
              onApply: () {
                widget.shopBloc.add(ApplyCoupon(_couponController.text));
                setState(() {});
              },
            ),
            const SizedBox(height: 14),
            CartTotalSummary(
              discountAmount: state.discountAmount,
              totalAmount: state.totalAmount,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: state.cartItems.isEmpty ? null : _checkout,
              child: const Text('Siparişi Tamamla'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDragHandle() {
    return Center(
      child: Container(
        width: 44,
        height: 5,
        decoration: BoxDecoration(
          color: AppColors.borderLight,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _checkout() {
    Navigator.pop(context); // sepeti kapat
    CheckoutBottomSheet.show(context, widget.shopBloc);
  }
}
