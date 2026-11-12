import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../models/cart_item_model.dart';

class CartItemList extends StatelessWidget {
  final List<CartItemModel> items;
  final void Function(String productId, int delta) onQuantityChanged;

  const CartItemList({
    super.key,
    required this.items,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 36),
        child: const Center(
          child: Column(
            children: [
              Icon(Icons.remove_shopping_cart_rounded, size: 48, color: AppColors.textMuted),
              SizedBox(height: 12),
              Text('Sepetiniz henüz boş.', style: AppTextStyles.bodyMuted),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (_, __) => const Divider(color: AppColors.borderLight, height: 16),
      itemBuilder: (context, index) {
        final item = items[index];
        return Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(item.product.icon, color: AppColors.primary, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.cardTitle.copyWith(fontSize: 13),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '₺${item.product.price.toStringAsFixed(2)}',
                    style: AppTextStyles.bodyMuted.copyWith(color: AppColors.primary),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () => onQuantityChanged(item.product.id, -1),
                  icon: const Icon(Icons.remove_circle_outline, size: 20, color: AppColors.primary),
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.all(4),
                ),
                Text(
                  '${item.quantity}',
                  style: AppTextStyles.cardTitle.copyWith(fontSize: 14),
                ),
                IconButton(
                  onPressed: () => onQuantityChanged(item.product.id, 1),
                  icon: const Icon(Icons.add_circle_outline, size: 20, color: AppColors.primary),
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.all(4),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

