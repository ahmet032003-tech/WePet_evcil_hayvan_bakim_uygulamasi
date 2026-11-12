import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/models/service_item_model.dart';
import '../../../core/widgets/badge_wrapper.dart';

class ServiceGridSection extends StatelessWidget {
  final List<ServiceItemModel> services;
  final ServiceItemModel? selectedService;
  final ValueChanged<ServiceItemModel> onServiceTap;

  const ServiceGridSection({
    super.key,
    required this.services,
    required this.onServiceTap,
    this.selectedService,
  });

  @override
  Widget build(BuildContext context) {
    if (services.length < 7) {
      return const SizedBox.shrink();
    }

    final topRow = services.sublist(0, 2);
    final middleRow = services.sublist(2, 5);
    final bottomRow = services.sublist(5, 7);

    return Column(
      children: [
        _buildRow(topRow, isCompact: false),
        const SizedBox(height: 14),
        _buildRow(middleRow, isCompact: true),
        const SizedBox(height: 14),
        _buildRow(bottomRow, isCompact: false),
      ],
    );
  }

  Widget _buildRow(List<ServiceItemModel> rowItems, {required bool isCompact}) {
    return Row(
      children: List.generate(rowItems.length, (index) {
        final item = rowItems[index];
        final isLast = index == rowItems.length - 1;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: isLast ? 0 : 12),
            child: _ServiceCard(
              item: item,
              isCompact: isCompact,
              isSelected: selectedService?.id == item.id,
              onTap: () => onServiceTap(item),
            ),
          ),
        );
      }),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final ServiceItemModel item;
  final bool isCompact;
  final bool isSelected;
  final VoidCallback onTap;

  const _ServiceCard({
    required this.item,
    required this.isCompact,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BadgeWrapper(
      badgeText: item.badgeText,
      badgeColor: item.badgeColor,
      isDiagonal: true,
      offset: const Offset(4, -6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: isCompact ? 114 : 108,
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isCompact ? 8 : 14,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? AppColors.primary : Colors.transparent,
              width: 1.5,
            ),
            boxShadow: AppColors.softShadow,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  item.icon,
                  color: AppColors.primary,
                  size: isCompact ? 24 : 26,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                item.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.cardTitle.copyWith(
                  fontSize: isCompact ? 11.5 : 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

