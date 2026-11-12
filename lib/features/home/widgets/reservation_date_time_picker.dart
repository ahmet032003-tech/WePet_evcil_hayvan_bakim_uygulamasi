import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import 'time_slot_selector.dart';

class ReservationDateTimePicker extends StatelessWidget {
  final DateTime selectedDate;
  final String selectedTimeSlot;
  final ValueChanged<DateTime> onDateChanged;
  final ValueChanged<String> onTimeSlotChanged;

  const ReservationDateTimePicker({
    super.key,
    required this.selectedDate,
    required this.selectedTimeSlot,
    required this.onDateChanged,
    required this.onTimeSlotChanged,
  });

  static const List<String> timeSlots = [
    '09:00',
    '11:00',
    '14:00',
    '16:30',
    '19:00',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Tarih & Saat Seçimi', style: AppTextStyles.cardTitle),
        const SizedBox(height: 10),
        _buildDatePickerCard(context),
        const SizedBox(height: 12),
        TimeSlotSelector(
          timeSlots: timeSlots,
          selectedTimeSlot: selectedTimeSlot,
          onTimeSlotChanged: onTimeSlotChanged,
        ),
      ],
    );
  }

  Widget _buildDatePickerCard(BuildContext context) {
    final dateStr = _formatDate(selectedDate);

    return InkWell(
      onTap: () => _pickDate(context),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.calendar_today_rounded,
                color: AppColors.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Rezervasyon Tarihi', style: AppTextStyles.badgeText),
                  const SizedBox(height: 2),
                  Text(
                    dateStr,
                    style: AppTextStyles.bodyRegular.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.edit_calendar_rounded, color: AppColors.primary, size: 20),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.isBefore(now) ? now : selectedDate,
      firstDate: now,
      lastDate: now.add(const Duration(days: 60)),
      builder: (ctx, child) {
        return Theme(
          data: Theme.of(ctx).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.cardSurface,
              surface: AppColors.cardSurface,
              onSurface: AppColors.textDark,
            ),
            dialogTheme: const DialogThemeData(
              backgroundColor: AppColors.cardSurface,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      onDateChanged(picked);
    }
  }

  String _formatDate(DateTime date) {
    const months = [
      '',
      'Ocak',
      'Şubat',
      'Mart',
      'Nisan',
      'Mayıs',
      'Haziran',
      'Temmuz',
      'Ağustos',
      'Eylül',
      'Ekim',
      'Kasım',
      'Aralık',
    ];
    return '${date.day} ${months[date.month]} ${date.year}';
  }
}
