import 'package:flutter/material.dart';

class ProductModel {
  final String id;
  final String name;
  final String category; // 'Mama', 'Oyuncak', 'Tasma', 'Bakım'
  final double price;
  final IconData icon;
  final String description;
  final double rating;

  const ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.icon,
    required this.description,
    this.rating = 4.8,
  });
}

