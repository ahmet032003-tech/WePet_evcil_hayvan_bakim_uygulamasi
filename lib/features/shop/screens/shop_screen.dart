import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/badge_wrapper.dart';
import '../bloc/shop_bloc.dart';
import '../bloc/shop_event.dart';
import '../bloc/shop_state.dart';
import '../widgets/cart_bottom_sheet.dart';
import '../widgets/product_grid_card.dart';
import '../widgets/shop_category_bar.dart';
import '../widgets/shop_promo_banner.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ShopBloc()..add(const LoadShopProducts()),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: _ShopAppBar(),
        body: BlocBuilder<ShopBloc, ShopState>(
          builder: (context, state) {
            if (state is ShopLoading || state is ShopInitial) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            }

            if (state is ShopLoaded) {
              return Column(
                children: [
                  const ShopPromoBanner(),
                  const SizedBox(height: 4),
                  ShopCategoryBar(
                    selectedCategory: state.selectedCategory,
                    onCategorySelected: (cat) {
                      context.read<ShopBloc>().add(FilterByCategory(cat));
                    },
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.72,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: state.filteredProducts.length,
                      itemBuilder: (ctx, i) {
                        final product = state.filteredProducts[i];
                        return ProductGridCard(
                          product: product,
                          onAddToCart: () {
                            context.read<ShopBloc>().add(AddToCart(product));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${product.name} sepete eklendi!'),
                                duration: const Duration(seconds: 1),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: AppColors.secondary,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _ShopAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: true,
      title: Text(
        'WePet Shop',
        style: AppTextStyles.appBarTitle.copyWith(color: AppColors.primary),
      ),
      actions: [
        BlocBuilder<ShopBloc, ShopState>(
          builder: (context, state) {
            final count = state is ShopLoaded ? state.totalItemCount : 0;
            return Padding(
              padding: const EdgeInsets.only(right: 14),
              child: BadgeWrapper(
                badgeText: count > 0 ? '$count' : null,
                badgeColor: AppColors.primary,
                child: IconButton(
                  onPressed: () {
                    final bloc = context.read<ShopBloc>();
                    CartBottomSheet.show(context, bloc);
                  },
                  icon: const Icon(Icons.shopping_bag_outlined, color: AppColors.textDark),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
