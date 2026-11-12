import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import 'badge_wrapper.dart';

class BottomNavItemData {
  final String label;
  final IconData icon;
  final String? badgeText;
  final Color? badgeColor;

  const BottomNavItemData({
    required this.label,
    required this.icon,
    this.badgeText,
    this.badgeColor,
  });
}

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomNavItemData> items;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.items = defaultItems,
  });

  static const List<BottomNavItemData> defaultItems = [
    BottomNavItemData(label: 'Ana Sayfa', icon: Icons.home_rounded),
    BottomNavItemData(
      label: 'Shop',
      icon: Icons.shopping_bag_rounded,
      badgeText: 'YENİ',
      badgeColor: AppColors.accentPurple,
    ),
    BottomNavItemData(label: 'Hizmetlerim', icon: Icons.pets_rounded),
    BottomNavItemData(
      label: 'PetFriends',
      icon: Icons.groups_rounded,
    ),
    BottomNavItemData(label: 'Profil', icon: Icons.person_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: AppColors.softShadow,
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              return Expanded(
                child: _NavBarItem(
                  item: items[index],
                  isSelected: index == currentIndex,
                  isCenterAction: index == 2,
                  onTap: () => onTap(index),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final BottomNavItemData item;
  final bool isSelected;
  final bool isCenterAction;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.item,
    required this.isSelected,
    required this.isCenterAction,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.primary : AppColors.textMuted;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BadgeWrapper(
              badgeText: item.badgeText,
              badgeColor: item.badgeColor,
              offset: const Offset(10, -6),
              badgePadding:
                  const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              child: isCenterAction
                  ? Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        boxShadow: AppColors.softShadow,
                      ),
                      child: Icon(item.icon, size: 22, color: AppColors.surface),
                    )
                  : Icon(item.icon, size: 24, color: color),
            ),
            const SizedBox(height: 4),
            Text(
              item.label,
              style: AppTextStyles.navLabel.copyWith(
                color: isCenterAction && isSelected ? AppColors.primary : color,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
