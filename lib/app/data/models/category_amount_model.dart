import 'package:flutter/material.dart';

class CategoryAmountModel {
  final String id;
  final String title;
  final IconData icon;
  final double? amount;

  CategoryAmountModel({
    required this.id,
    required this.title,
    required this.icon,
    this.amount,
  });

  CategoryAmountModel copyWith({
    String? id,
    String? title,
    IconData? icon,
    double? amount,
  }) {
    return CategoryAmountModel(
      id: id ?? this.id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      amount: amount ?? this.amount,
    );
  }

  String get formattedAmount {
    if (amount == null) return '';
    return '+ \$${amount!.toStringAsFixed(2)}';
  }
}

