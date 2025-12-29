import 'package:flutter/material.dart';

class ProfileDonationCategoryModel {
  final String id;
  final String name;
  final double percentage;
  final Color color;

  ProfileDonationCategoryModel({
    required this.id,
    required this.name,
    required this.percentage,
    required this.color,
  });

  ProfileDonationCategoryModel copyWith({
    String? id,
    String? name,
    double? percentage,
    Color? color,
  }) {
    return ProfileDonationCategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      percentage: percentage ?? this.percentage,
      color: color ?? this.color,
    );
  }
}

