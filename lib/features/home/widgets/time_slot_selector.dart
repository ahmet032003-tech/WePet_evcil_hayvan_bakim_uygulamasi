import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class TimeSlotSelector extends StatelessWidget {
  final List<String> timeSlots;
  final String selectedTimeSlot;
  final ValueChanged<String> onTimeSlotChanged;

  const TimeSlotSelector({
    super.key,
    required this.timeSlots,
    required this.selectedTimeSlot,
    required this.onTimeSlotChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: timeSlots.map((slot) {
          final isSelected = selectedTimeSlot == slot;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(
                slot,
                style: TextStyle(
                  color: isSelected ? AppColors.cardSurface : AppColors.textDark,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.5,
                ),
              ),
              selected: isSelected,
              selectedColor: AppColors.primary,
              backgroundColor: AppColors.background,
              showCheckmark: false,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: BorderSide(
                  color: isSelected ? AppColors.primary : AppColors.borderLight,
                ),
              ),
              onSelected: (_) => onTimeSlotChanged(slot),
            ),
          );
        }).toList(),
      ),
    );
  }
}

