import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../constants/shop_mock_data.dart';
import '../../features/shop/models/cart_item_model.dart';
import '../../features/shop/models/product_model.dart';

class ShopRepository {
  final FirebaseFirestore _firestore;

  ShopRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<ProductModel>> fetchProducts() async {
    final snapshot = await _firestore.collection('products').get();
    if (snapshot.docs.isEmpty) {
      await _seedProducts();
      return ShopMockData.shopProducts;
    }
    return snapshot.docs.map((d) {
      final data = d.data();
      final iconCode =
          data['iconCode'] as int? ?? Icons.pets_rounded.codePoint;
      return ProductModel(
        id: d.id,
        name: data['name'] ?? '',
        category: data['category'] ?? 'Mama',
        price: (data['price'] as num?)?.toDouble() ?? 0.0,
        // ignore: non_const_argument_for_const_parameter
        icon: IconData(iconCode, fontFamily: 'MaterialIcons'),
        description: data['description'] ?? '',
        rating: (data['rating'] as num?)?.toDouble() ?? 4.8,
      );
    }).toList();
  }

  Future<void> _seedProducts() async {
    final batch = _firestore.batch();
    for (final prod in ShopMockData.shopProducts) {
      final ref = _firestore.collection('products').doc(prod.id);
      batch.set(ref, {
        'name': prod.name,
        'category': prod.category,
        'price': prod.price,
        'iconCode': prod.icon.codePoint,
        'description': prod.description,
        'rating': prod.rating,
      });
    }
    await batch.commit();
  }

  Future<void> createOrder({
    required String uid,
    required List<CartItemModel> items,
    required double totalAmount,
    required String addressTitle,
    required String cardLastFour,
  }) async {
    await _firestore.collection('orders').add({
      'userId': uid,
      'totalAmount': totalAmount,
      'addressTitle': addressTitle,
      'cardLastFour': cardLastFour,
      'items': items
          .map((i) => {
                'productId': i.product.id,
                'name': i.product.name,
                'quantity': i.quantity,
                'price': i.product.price,
              })
          .toList(),
      'status': 'preparing',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
