import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class BadgeWrapper extends StatelessWidget {
  final Widget child;
  final String? badgeText;
  final Color? badgeColor;
  final Color? textColor;
  final Alignment alignment;
  final Offset offset;
  final EdgeInsetsGeometry badgePadding;
  final bool isDiagonal;

  const BadgeWrapper({
    super.key,
    required this.child,
    this.badgeText,
    this.badgeColor,
    this.textColor,
    this.alignment = Alignment.topRight,
    this.offset = const Offset(4, -6),
    this.badgePadding = const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    this.isDiagonal = false,
  });

  @override
  Widget build(BuildContext context) {
    if (badgeText == null || badgeText!.trim().isEmpty) {
      return child;
    }

    final badgeContent = Container(
      padding: badgePadding,
      decoration: BoxDecoration(
        color: badgeColor ?? AppColors.accentYellow,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppColors.softShadow,
      ),
      child: Text(
        badgeText!,
        style: AppTextStyles.badgeText.copyWith(
          color: textColor ?? AppColors.surface,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );

    return Stack(
      clipBehavior: Clip.none,
      alignment: alignment,
      children: [
        child,
        Transform.translate(
          offset: offset,
          child: isDiagonal
              ? Transform.rotate(
                  angle: math.pi / 10,
                  child: badgeContent,
                )
              : badgeContent,
        ),
      ],
    );
  }
}
