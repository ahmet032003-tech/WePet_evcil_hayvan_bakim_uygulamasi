import 'package:flutter/material.dart';

enum ReservationStatus { active, completed }

class ReservationModel {
  final String id;
  final String serviceTitle;
  final IconData serviceIcon;
  final DateTime date;
  final String timeSlot;
  final String duration;
  final String? packageOption;
  final double price;
  final ReservationStatus status;

  const ReservationModel({
    required this.id,
    required this.serviceTitle,
    required this.serviceIcon,
    required this.date,
    required this.timeSlot,
    required this.duration,
    this.packageOption,
    required this.price,
    this.status = ReservationStatus.active,
  });

  String get effectiveOption => packageOption ?? duration;

  ReservationModel copyWith({
    String? id,
    String? serviceTitle,
    IconData? serviceIcon,
    DateTime? date,
    String? timeSlot,
    String? duration,
    String? packageOption,
    double? price,
    ReservationStatus? status,
  }) {
    return ReservationModel(
      id: id ?? this.id,
      serviceTitle: serviceTitle ?? this.serviceTitle,
      serviceIcon: serviceIcon ?? this.serviceIcon,
      date: date ?? this.date,
      timeSlot: timeSlot ?? this.timeSlot,
      duration: duration ?? this.duration,
      packageOption: packageOption ?? this.packageOption,
      price: price ?? this.price,
      status: status ?? this.status,
    );
  }
}
