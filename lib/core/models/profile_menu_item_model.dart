import 'package:flutter/material.dart';

class ProfileMenuItemModel {
  final String id;
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const ProfileMenuItemModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  ProfileMenuItemModel copyWith({
    String? id,
    String? title,
    IconData? icon,
    VoidCallback? onTap,
  }) {
    return ProfileMenuItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      onTap: onTap ?? this.onTap,
    );
  }
}
