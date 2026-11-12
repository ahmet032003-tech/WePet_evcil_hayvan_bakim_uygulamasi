import '../models/product_model.dart';

abstract class ShopEvent {
  const ShopEvent();
}

class LoadShopProducts extends ShopEvent {
  const LoadShopProducts();
}

class FilterByCategory extends ShopEvent {
  final String category;

  const FilterByCategory(this.category);
}

class AddToCart extends ShopEvent {
  final ProductModel product;

  const AddToCart(this.product);
}

class RemoveFromCart extends ShopEvent {
  final String productId;

  const RemoveFromCart(this.productId);
}

class UpdateQuantity extends ShopEvent {
  final String productId;
  final int delta;

  const UpdateQuantity(this.productId, this.delta);
}

class ApplyCoupon extends ShopEvent {
  final String couponCode;

  const ApplyCoupon(this.couponCode);
}

class ClearCartAndCheckout extends ShopEvent {
  const ClearCartAndCheckout();
}

