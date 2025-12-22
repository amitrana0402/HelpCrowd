import 'package:flutter/material.dart';

class DonationCategoryModel {
  final String id;
  final String title;
  final IconData icon;
  final bool isSelected;

  DonationCategoryModel({
    required this.id,
    required this.title,
    required this.icon,
    this.isSelected = false,
  });

  DonationCategoryModel copyWith({
    String? id,
    String? title,
    IconData? icon,
    bool? isSelected,
  }) {
    return DonationCategoryModel(
      id: id ?? this.id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
