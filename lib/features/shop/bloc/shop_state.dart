import '../models/cart_item_model.dart';
import '../models/product_model.dart';

abstract class ShopState {
  const ShopState();
}

class ShopInitial extends ShopState {
  const ShopInitial();
}

class ShopLoading extends ShopState {
  const ShopLoading();
}

class ShopLoaded extends ShopState {
  final List<ProductModel> allProducts;
  final List<ProductModel> filteredProducts;
  final String selectedCategory;
  final List<CartItemModel> cartItems;
  final double discountAmount;
  final String? appliedCoupon;

  const ShopLoaded({
    required this.allProducts,
    required this.filteredProducts,
    this.selectedCategory = 'Tümü',
    this.cartItems = const [],
    this.discountAmount = 0.0,
    this.appliedCoupon,
  });

  int get totalItemCount =>
      cartItems.fold<int>(0, (sum, item) => sum + item.quantity);

  double get subtotalAmount =>
      cartItems.fold<double>(0.0, (sum, item) => sum + item.totalPrice);

  double get totalAmount {
    final net = subtotalAmount - discountAmount;
    return net > 0 ? net : 0.0;
  }

  ShopLoaded copyWith({
    List<ProductModel>? allProducts,
    List<ProductModel>? filteredProducts,
    String? selectedCategory,
    List<CartItemModel>? cartItems,
    double? discountAmount,
    String? appliedCoupon,
    bool clearCoupon = false,
  }) {
    return ShopLoaded(
      allProducts: allProducts ?? this.allProducts,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      cartItems: cartItems ?? this.cartItems,
      discountAmount: discountAmount ?? this.discountAmount,
      appliedCoupon: clearCoupon ? null : (appliedCoupon ?? this.appliedCoupon),
    );
  }
}

class ShopOrderSuccess extends ShopState {
  final double orderTotal;

  const ShopOrderSuccess({required this.orderTotal});
}

