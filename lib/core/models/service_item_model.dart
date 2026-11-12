import 'package:flutter/material.dart';

class ServiceItemModel {
  final String id;
  final String title;
  final IconData icon;
  final String? badgeText;
  final Color? badgeColor;

  const ServiceItemModel({
    required this.id,
    required this.title,
    required this.icon,
    this.badgeText,
    this.badgeColor,
  });
}

