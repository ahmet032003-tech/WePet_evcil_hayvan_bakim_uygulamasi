import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/shop_mock_data.dart';
import '../../../core/repositories/shop_repository.dart';
import '../models/cart_item_model.dart';
import '../models/product_model.dart';
import 'shop_event.dart';
import 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  final ShopRepository _shopRepo;

  ShopBloc({ShopRepository? shopRepo})
      : _shopRepo = shopRepo ?? ShopRepository(),
        super(const ShopInitial()) {
    on<LoadShopProducts>(_onLoadShopProducts);
    on<FilterByCategory>(_onFilterByCategory);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateQuantity>(_onUpdateQuantity);
    on<ApplyCoupon>(_onApplyCoupon);
    on<ClearCartAndCheckout>(_onClearCartAndCheckout);
  }

  Future<void> _onLoadShopProducts(
    LoadShopProducts event,
    Emitter<ShopState> emit,
  ) async {
    List<ProductModel> products = ShopMockData.shopProducts;
    try {
      products = await _shopRepo.fetchProducts();
    } catch (_) {}

    emit(ShopLoaded(
      allProducts: products,
      filteredProducts: products,
      selectedCategory: 'Tümü',
    ));
  }

  void _onFilterByCategory(FilterByCategory event, Emitter<ShopState> emit) {
    final s = state;
    if (s is ShopLoaded) {
      final filtered = event.category == 'Tümü'
          ? s.allProducts
          : s.allProducts.where((p) => p.category == event.category).toList();
      emit(s.copyWith(
        selectedCategory: event.category,
        filteredProducts: filtered,
      ));
    }
  }

  void _onAddToCart(AddToCart event, Emitter<ShopState> emit) {
    final s = state;
    if (s is ShopLoaded) {
      final items = List<CartItemModel>.from(s.cartItems);
      final idx = items.indexWhere((i) => i.product.id == event.product.id);
      if (idx >= 0) {
        items[idx] = items[idx].copyWith(quantity: items[idx].quantity + 1);
      } else {
        items.add(CartItemModel(product: event.product, quantity: 1));
      }
      emit(s.copyWith(cartItems: items));
    }
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<ShopState> emit) {
    final s = state;
    if (s is ShopLoaded) {
      final items = s.cartItems.where((i) => i.product.id != event.productId).toList();
      emit(s.copyWith(cartItems: items));
    }
  }

  void _onUpdateQuantity(UpdateQuantity event, Emitter<ShopState> emit) {
    final s = state;
    if (s is ShopLoaded) {
      final items = List<CartItemModel>.from(s.cartItems);
      final idx = items.indexWhere((i) => i.product.id == event.productId);
      if (idx >= 0) {
        final newQty = items[idx].quantity + event.delta;
        if (newQty <= 0) {
          items.removeAt(idx);
        } else {
          items[idx] = items[idx].copyWith(quantity: newQty);
        }
        emit(s.copyWith(cartItems: items));
      }
    }
  }

  void _onApplyCoupon(ApplyCoupon event, Emitter<ShopState> emit) {
    final s = state;
    if (s is ShopLoaded) {
      if (event.couponCode.trim().toUpperCase() == 'WELCOME200') {
        emit(s.copyWith(
          discountAmount: 200.0,
          appliedCoupon: 'WELCOME200',
        ));
      }
    }
  }

  Future<void> _onClearCartAndCheckout(
    ClearCartAndCheckout event,
    Emitter<ShopState> emit,
  ) async {
    final s = state;
    if (s is ShopLoaded && s.cartItems.isNotEmpty) {
      final total = s.totalAmount;
      emit(ShopOrderSuccess(orderTotal: total));
      emit(ShopLoaded(
        allProducts: s.allProducts,
        filteredProducts: s.filteredProducts,
        selectedCategory: s.selectedCategory,
        cartItems: const [],
        discountAmount: 0.0,
        appliedCoupon: null,
      ));
    }
  }
}
