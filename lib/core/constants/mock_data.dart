import 'package:flutter/material.dart';
import '../models/pet_profile_model.dart';
import '../models/profile_menu_item_model.dart';
import '../models/service_item_model.dart';
import 'app_colors.dart';
import 'shop_mock_data.dart';
import '../../features/shop/models/product_model.dart';

class MockData {
  MockData._();

  static List<ProductModel> get shopProducts => ShopMockData.shopProducts;

  // Ana Sayfa Hizmet Kartları (UI_SPECS.md - Ekran 1)
  static const List<ServiceItemModel> homeServices = [
    ServiceItemModel(
      id: 'single_walk',
      title: 'TEK YÜRÜYÜŞ',
      icon: Icons.bolt_rounded,
    ),
    ServiceItemModel(
      id: 'routine_walk',
      title: 'RUTİN YÜRÜYÜŞ',
      icon: Icons.calendar_month_rounded,
      badgeText: '%10',
      badgeColor: AppColors.accentYellow,
    ),
    ServiceItemModel(
      id: 'dog_home_care',
      title: 'KÖPEK EVDE BAKIM',
      icon: Icons.pets_rounded,
    ),
    ServiceItemModel(
      id: 'cat_home_care',
      title: 'KEDİ EVDE BAKIM',
      icon: Icons.cruelty_free_rounded,
    ),
    ServiceItemModel(
      id: 'mobile_pet_grooming',
      title: 'MOBİL PET KUAFÖR',
      icon: Icons.content_cut_rounded,
      badgeText: 'YENİ',
      badgeColor: AppColors.accentPurple,
    ),
    ServiceItemModel(
      id: 'wepet_shop',
      title: 'WePet Shop',
      icon: Icons.shopping_bag_rounded,
      badgeText: '200 TL Kazan!',
      badgeColor: AppColors.accentYellow,
    ),
    ServiceItemModel(
      id: 'dog_training',
      title: 'KÖPEK EĞİTİMİ',
      icon: Icons.sports_rounded,
      badgeText: 'Bedava Tanışma',
      badgeColor: AppColors.primary,
    ),
  ];

  static const List<ServiceItemModel> serviceItems = homeServices;

  // Örnek Pet Profilleri (UI_SPECS.md - PetProfileModel)
  static const List<PetProfileModel> samplePets = [
    PetProfileModel(
      id: 'pet_1',
      name: 'Tarçın',
      type: PetType.dog,
      breed: 'Golden Retriever',
      age: 3,
    ),
    PetProfileModel(
      id: 'pet_2',
      name: 'Mia',
      type: PetType.cat,
      breed: 'British Shorthair',
      age: 2,
    ),
  ];

  // Profil Ekranı Liste Menüsü (UI_SPECS.md - Ekran 4)
  static List<ProfileMenuItemModel> getProfileMenu({
    VoidCallback? onTapDefault,
    void Function(String title, IconData icon)? onMenuSelected,
  }) =>
      getProfileMenuItems(
        onTapDefault: onTapDefault,
        onMenuSelected: onMenuSelected,
      );

  static List<ProfileMenuItemModel> getProfileMenuItems({
    VoidCallback? onTapDefault,
    void Function(String title, IconData icon)? onMenuSelected,
  }) {
    void handleTap(String title, IconData icon) {
      if (onMenuSelected != null) {
        onMenuSelected(title, icon);
      } else {
        onTapDefault?.call();
      }
    }

    return [
      ProfileMenuItemModel(
        id: 'personal_info',
        title: 'Kişisel Bilgiler',
        icon: Icons.person_outline_rounded,
        onTap: () => handleTap('Kişisel Bilgiler', Icons.person_outline_rounded),
      ),
      ProfileMenuItemModel(
        id: 'wepet_code',
        title: 'WePet Kodunuz',
        icon: Icons.card_giftcard_rounded,
        onTap: () => handleTap('WePet Kodunuz', Icons.card_giftcard_rounded),
      ),
      ProfileMenuItemModel(
        id: 'addresses',
        title: 'Adreslerim',
        icon: Icons.location_on_outlined,
        onTap: () => handleTap('Adreslerim', Icons.location_on_outlined),
      ),
      ProfileMenuItemModel(
        id: 'payment_method',
        title: 'Ödeme Yöntemi',
        icon: Icons.credit_card_rounded,
        onTap: () => handleTap('Ödeme Yöntemi', Icons.credit_card_rounded),
      ),
      ProfileMenuItemModel(
        id: 'help',
        title: 'Yardım',
        icon: Icons.help_outline_rounded,
        onTap: () => handleTap('Yardım', Icons.help_outline_rounded),
      ),
      ProfileMenuItemModel(
        id: 'become_walker',
        title: 'Hemen Walker Ol',
        icon: Icons.directions_walk_rounded,
        onTap: () => handleTap('Hemen Walker Ol', Icons.directions_walk_rounded),
      ),
    ];
  }
}

