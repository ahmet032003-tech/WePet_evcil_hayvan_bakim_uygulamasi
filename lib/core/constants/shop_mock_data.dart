import 'package:flutter/material.dart';
import '../../features/shop/models/product_model.dart';

class ShopMockData {
  ShopMockData._();

  static const List<ProductModel> shopProducts = [
    ProductModel(
      id: 'prod_1',
      name: 'Somonlu Yetişkin Köpek Maması 3kg',
      category: 'Mama',
      price: 549.90,
      icon: Icons.pets_rounded,
      description: 'Zengin omega-3 içeriği ve yüksek proteinli premium somonlu kuru mama.',
      rating: 4.9,
    ),
    ProductModel(
      id: 'prod_2',
      name: 'Kedi Oltası & Tüy Oyuncak',
      category: 'Oyuncak',
      price: 129.50,
      icon: Icons.attractions_rounded,
      description: 'Kedinizin avcılık içgüdülerini harekete geçiren dayanıklı interaktif olta.',
      rating: 4.7,
    ),
    ProductModel(
      id: 'prod_3',
      name: 'Deri & Yansıtıcılı Köpek Tasması',
      category: 'Tasma',
      price: 289.00,
      icon: Icons.radio_button_checked_rounded,
      description: 'Gece yürüyüşlerinde parlayan yansıtıcı dikişli yumuşak hakiki deri tasma.',
      rating: 4.8,
    ),
    ProductModel(
      id: 'prod_4',
      name: 'Otomatik Su Pınarı 2.5L',
      category: 'Bakım',
      price: 680.00,
      icon: Icons.water_drop_rounded,
      description: '4 katmanlı filtreleme sistemli, ultra sessiz evcil hayvan su sebili.',
      rating: 4.9,
    ),
    ProductModel(
      id: 'prod_5',
      name: 'Pati Temizleme Köpüğü 150ml',
      category: 'Bakım',
      price: 145.00,
      icon: Icons.clean_hands_rounded,
      description: 'Durulama gerektirmeyen organik aloe vera özlü antibakteriyel pati köpüğü.',
      rating: 4.6,
    ),
    ProductModel(
      id: 'prod_6',
      name: 'Zeka Geliştirici Ödül Topu',
      category: 'Oyuncak',
      price: 175.00,
      icon: Icons.sports_baseball_rounded,
      description: 'İçine ödül maması saklanabilen diş sağlığını destekleyen kauçuk zeka topu.',
      rating: 4.8,
    ),
    ProductModel(
      id: 'prod_7',
      name: 'Tavuklu Kısır Kedi Maması 2kg',
      category: 'Mama',
      price: 420.00,
      icon: Icons.set_meal_rounded,
      description: 'Kısırlaştırılmış kedilerin kilo kontrolünü ve idrar yolu sağlığını korur.',
      rating: 4.9,
    ),
    ProductModel(
      id: 'prod_8',
      name: 'Otomatik Kilitli Gezdirme Kayışı 5m',
      category: 'Tasma',
      price: 340.00,
      icon: Icons.linear_scale_rounded,
      description: 'Ergonomik tutuşlu, 25 kg ağırlığa kadar dayanıklı otomatik uzayan şerit kayış.',
      rating: 4.7,
    ),
  ];
}

